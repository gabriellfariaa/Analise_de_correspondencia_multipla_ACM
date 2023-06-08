Com base nas informações públicas disponíveis no site Fundamentus, o objetivo deste repositório desenvolver um Mapa Perceptual das Ações presentes em minha Carteira Pessoal. Tal Mapa irá me auxiliar nos aportes mensais, levando em conta conceitos fundamentais e um enfoque de longo prazo.

Para realizar o Web Scraping [Acesse meu outro repositório -  WebScraping_Site_Fudamentus](https://github.com/gabriellfariaa/WebScraping_Site_Fudamentus)

A Análise de Correspondência Múltipla (ACM) é uma técnica de Machine Learning Não Supervisionada que tem como objetivo produzir resultados para fins exploratórios e diagnósticos. A ACM é capaz de analisar a associação entre mais de duas variáveis, tornando-se uma ferramenta valiosa para a compreensão de dados complexos.

### Premissas:

Somente as variáveis que apresentam associação estatisticamente significativa com pelo menos uma outra variável incluída na análise são consideradas na ACM;
Antes de elaborar a ACM, é importante realizar um teste χ2 para cada par de variáveis;
Caso alguma variável não apresente associação com as demais, ela não será considerada na análise de correspondência.

## Análise de correspondência no Studio R:
Instalação e carregamento dos pacotes utilizados

(“plotly”, “tidyverse”, “ggrepel”,“knitr”, “kableExtra”, “sjPlot”, “FactoMineR”,“amap”, “ade4”,“readxl”)

Importando a base de dados, removido as variáveis que não utilizaremos e selecionado as ações que tenho em minha carteira.

![image](https://github.com/gabriellfariaa/ACM/assets/111810067/d199c812-0372-4c3a-922b-83f1186a2f7e)

### A Categorização qualitativa é de acordo com o perfil de cada investidor, através de conhecimentos específicos e fundamentalista.

- Categoria P/L: ≤0 = Negativo / >0 e ≤10% = Bom / >10% Ótimo;
- Categoria P/VP: ≤0 = Negativo / >0 = Positivo;
- Categoria Div.Yield: ≤0 = Nulo / >0 e ≤5% = Bom / >5% Ótimo;
- Categoria ROE: ≤0 = Negativo/ >0 e ≤10% = Bom / >10% Ótimo;
- Categoria Margem Liq: ≤0 = Negativo / >0 = Positivo;
- Categoria Cresc. 5 anos: ≤0 = Negativo / >0 = Positivo;

## Alteração para fatores e realizado a tabela de contingência para analisar se todas as variáveis apresentam associações entre elas.
![image](https://miro.medium.com/v2/resize:fit:640/format:webp/1*LmxMmxDlovFDZ5oZtmWc_w.png)

No exemplo mencionado acima, foi analisada a associação entre as categorias de ROE e Dividend Yield. O resultado apresentou um p-valor menor do que o nível de significância de 5%, o que significa que a hipótese nula foi rejeitada e podemos considerar que há uma associação significativa entre essas duas variáveis.

# Plotando o mapa perceptual
![image](https://miro.medium.com/v2/resize:fit:1400/format:webp/1*6R2nXF57ixCBHHz7QM-eFQ.png)

# Conclusão
Com base na análise do Mapa Perceptual, podemos concluir que as ações mais interessantes para investimentos recorrentes são aquelas identificadas no segundo e terceiro quadrante do mapa. Essas empresas apresentam associações positivas entre Margem Líquida, ROE, P/L e Dividend Yield ótimo, além de apresentar crescimento nos últimos 5 anos. As empresas que se enquadram nesse perfil são: TAEE11, CSMG3, BRSR6, FLRY3, SAPR4 e ODPV3.

É importante ressaltar que o papel AMER3 encontra-se em um quadrante interessante, porém, recentemente foi divulgado um rombo contábil em janeiro de 2023, e essa informação ainda não está refletida nos dados extraídos do site.

É importante mencionar os papéis que não são considerados interessantes no momento e que não serão objeto de investimentos nos próximos meses ou até mesmo anos. São eles: MGLU3, MEAL3, IRBR3 e COGN3.


