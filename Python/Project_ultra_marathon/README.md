# Análise Exploratória de Dados de Ultramaratonas (2020, EUA)

Bem-vindo ao repositório do projeto de análise exploratória de dados baseado em uma base de dados de ultramaratonas disponível no [Kaggle](https://www.kaggle.com/datasets/aiaiaidavid/the-big-dataset-of-ultra-marathon-running/discussion/420633). Este projeto foi desenvolvido em Python e foca em corridas de 50 km e 50 milhas realizadas nos Estados Unidos no ano de 2020. Abaixo, você encontrará uma visão geral do projeto, os objetivos, a metodologia e como executar o código.

## Sobre o Projeto

A base de dados original contém registros de ultramaratonas de 1798 até 2022. Para este estudo, foram selecionados:
- **Distâncias**: Corridas de 50 km e 50 milhas (50 mi).
- **Ano**: 2020.
- **Localização**: Apenas corridas realizadas nos Estados Unidos (USA).

O objetivo foi realizar uma análise exploratória para responder perguntas específicas sobre o desempenho dos atletas, considerando variáveis como idade, gênero, velocidade e sazonalidade.

### Perguntas Respondidas
1. **Qual a média de idade dos atletas?**  
   Exploração da distribuição etária dos participantes.
2. **Diferença de velocidade entre homens e mulheres nas distâncias de 50 km e 50 mi?**  
   Comparação de desempenho entre gêneros em cada distância.
3. **Quais faixas etárias são as melhores na corrida de 50 mi?**  
   Identificação das idades com maior desempenho na distância de 50 milhas.
4. **Quais faixas etárias são as piores na corrida de 50 mi?**  
   Identificação das idades com menor desempenho na distância de 50 milhas.
5. **A velocidade média dos atletas é mais lenta no verão do que no inverno?**  
   Análise da influência da sazonalidade no desempenho dos corredores.

## Estrutura do Repositório

- **`data/`**: Contém o arquivo de dados brutos baixado do Kaggle (não incluído no repositório por questões de tamanho; veja a seção "Dados" para mais detalhes).
- **`notebooks/`**: Jupyter Notebook com o código da análise exploratória (`project_ultra_marathon.ipynb`).
- **`README.md`**: Este arquivo.

## Metodologia

1. **Coleta de Dados**:  
   A base de dados foi obtida no Kaggle e contém informações históricas de ultramaratonas, como idade dos atletas, gênero, tempo de prova, distância, data e localização.

2. **Pré-processamento**:  
   - Filtragem para incluir apenas corridas de 50 km e 50 mi, realizadas em 2020 nos EUA.  
   - Limpeza de dados: tratamento de valores ausentes, conversão de unidades (quando necessário) e padronização de colunas.  

3. **Análise Exploratória**:  
   Uso de bibliotecas como `pandas` e `seaborn` para explorar os dados e responder às perguntas propostas. Foram gerados gráficos e estatísticas descritivas para suportar as conclusões.

## Resultados

Os principais insights estão documentados no notebook project_ultra_marathon.ipynb. Exemplos de saídas incluem:

Gráficos de distribuição de idade.
Comparativos de velocidade por gênero e distância.
Rankings de desempenho por faixa etária.
Análise sazonal com médias de velocidade no verão e inverno.

