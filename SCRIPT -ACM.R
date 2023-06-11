### Análise de Correspondência Múltipla

# Instalação e carregamento dos pacotes utilizados
pacotes <- c("plotly", 
             "tidyverse", 
             "ggrepel",
             "knitr", "kableExtra", 
             "sjPlot", 
             "FactoMineR", 
             "amap", 
             "ade4",
             "readxl")

if(sum(as.numeric(!pacotes %in% installed.packages())) != 0){
  instalador <- pacotes[!pacotes %in% installed.packages()]
  for(i in 1:length(instalador)) {
    install.packages(instalador, dependencies = T)
    break()}
  sapply(pacotes, require, character = T) 
} else {
  sapply(pacotes, require, character = T) 
}

# Importando a base de dados
dados_acoes <- read_excel("Base_fundamentus.xlsx")


## Base de dados já alterado para variáveis qualitativas


# Remover as variáveis que não utilizaremos
dados_acoes <- dados_acoes %>% 
  select(-PSR, -Cotacao, -P_Ativo, -P_CapGiro, -P_EBIT, -P_AtivCircLiq, -EV_EBIT, -EV_EBITDA, -MrgEbit, -LiqCorr, -ROIC, -Liq2meses, -PatrimLiq, -DivBrut_Patrim, -P_L, -P_VP, -DivYield, -MrgLiq, -ROE, -CrescRec5a,
  )

# Selecionar as Ações que tenho na Carteira
dados_acoes <- dados_acoes %>% 
  filter(Papel=="TAEE11" |
           Papel=="CSMG3"  |
           Papel=="FLRY3"  |
           Papel=="BRSR6"  |
           Papel=="BBSE3"  |
           Papel=="COGN3"  |
           Papel=="IRBR3"  |
           Papel=="MEAL3"  |
           Papel=="MGLU3"  |
           Papel=="ODPV3"  |
           Papel=="SAPR4"  |
           Papel=="AMER3",) 

summary(dados_acoes)


# A função para a criação da ACM pede que sejam utilizados "fatores"
dados_acoes <- as.data.frame(unclass(dados_acoes), stringsAsFactors=TRUE)

# Tabelas de contingência (todas apresentam associação com alguma variável?)
sjt.xtab(var.row = dados_acoes$Categ_DivYield,
         var.col = dados_acoes$Categ_PL,
         show.exp = TRUE,
         show.row.prc = TRUE,
         show.col.prc = TRUE, 
         encoding = "UTF-8")

sjt.xtab(var.row = dados_acoes$Categ_DivYield,
         var.col = dados_acoes$Categ_PVP,
         show.exp = TRUE,
         show.row.prc = TRUE,
         show.col.prc = TRUE, 
         encoding = "UTF-8")

sjt.xtab(var.row = dados_acoes$Categ_DivYield,
         var.col = dados_acoes$Categ_ROE,
         show.exp = TRUE,
         show.row.prc = TRUE,
         show.col.prc = TRUE, 
         encoding = "UTF-8")

sjt.xtab(var.row = dados_acoes$Categ_PL,
         var.col = dados_acoes$Categ_MrgLiq,
         show.exp = TRUE,
         show.row.prc = TRUE,
         show.col.prc = TRUE, 
         encoding = "UTF-8")

sjt.xtab(var.row = dados_acoes$Categ_PL,
         var.col = dados_acoes$Categ_Cresc5a,
         show.exp = TRUE,
         show.row.prc = TRUE,
         show.col.prc = TRUE, 
         encoding = "UTF-8")

sjt.xtab(var.row = dados_acoes$Categ_PL,
         var.col = dados_acoes$Categ_DivYield,
         show.exp = TRUE,
         show.row.prc = TRUE,
         show.col.prc = TRUE, 
         encoding = "UTF-8")



# Vamos gerar a ACM
ACM <- dudi.acm(dados_acoes, scannf = FALSE)

# Analisando as variâncias de cada dimensão
perc_variancia <- (ACM$eig / sum(ACM$eig)) * 100
paste0(round(perc_variancia,2),"%")

# Quantidade de categorias por variável
quant_categorias <- apply(dados_acoes,
                          MARGIN =  2,
                          FUN = function(x) nlevels(as.factor(x)))

# Consolidando as coordenadas-padrão obtidas por meio da matriz binária
df_ACM <- data.frame(ACM$c1, Variável = rep(names(quant_categorias),
                                            quant_categorias))

# Plotando o mapa perceptual
df_ACM %>%
  rownames_to_column() %>%
  rename(Categoria = 1) %>%
  ggplot(aes(x = CS1, y = CS2, label = Categoria, color = Variável)) +
  geom_point() +
  geom_label_repel() +
  geom_vline(aes(xintercept = 0), linetype = "longdash", color = "grey48") +
  geom_hline(aes(yintercept = 0), linetype = "longdash", color = "grey48") +
  labs(x = paste("Dimensão 1:", paste0(round(perc_variancia[1], 2), "%")),
       y = paste("Dimensão 2:", paste0(round(perc_variancia[2], 2), "%"))) +
  theme_bw()

# Poderíamos fazer o mapa com as coordenadas obtidas por meio da matriz de Burt

# Consolidando as coordenadas-padrão obtidas por meio da matriz de Burt
df_ACM_B <- data.frame(ACM$co, Variável = rep(names(quant_categorias),
                                              quant_categorias))

# Plotando o mapa perceptual
df_ACM_B %>%
  rownames_to_column() %>%
  rename(Categoria = 1) %>%
  ggplot(aes(x = Comp1, y = Comp2, label = Categoria, color = Variável)) +
  geom_point() +
  geom_label_repel() +
  geom_vline(aes(xintercept = 0), linetype = "longdash", color = "grey48") +
  geom_hline(aes(yintercept = 0), linetype = "longdash", color = "grey48") +
  labs(x = paste("Dimensão 1:", paste0(round(perc_variancia[1], 2), "%")),
       y = paste("Dimensão 2:", paste0(round(perc_variancia[2], 2), "%"))) +
  theme_bw()

# É possível obter as coordenadas das observações
df_coord_obs <- ACM$li

# Plotando o mapa perceptual
df_coord_obs %>%
  ggplot(aes(x = Axis1, y = Axis2, color = dados_acoes$Categ_DivYield)) +
  geom_point() +
  geom_vline(aes(xintercept = 0), linetype = "longdash", color = "grey48") +
  geom_hline(aes(yintercept = 0), linetype = "longdash", color = "grey48") +
  labs(x = paste("Dimensão 1:", paste0(round(perc_variancia[1], 2), "%")),
       y = paste("Dimensão 2:", paste0(round(perc_variancia[2], 2), "%")),
       color = "Div.Yield") +
  theme_bw()

# Fim!
