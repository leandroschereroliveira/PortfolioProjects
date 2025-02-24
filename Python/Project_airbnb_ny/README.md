# Projeto EDA de Aluguéis do Airbnb: Nova York 2024

<p align="center">
  <img src="./airbnb.png" alt="Imagem">
</p>


Este projeto realiza uma Análise Exploratória de Dados (EDA) em dados do Airbnb de Nova York para identificar tendências e padrões nas listagens de aluguel. Utilizamos bibliotecas como Pandas, Numpy, Matplotlib e Seaborn para limpeza, visualização e análise.

## 🎯 Objetivo
O objetivo deste projeto é:

- Analisar os tipos de quartos, preços e disponibilidade em diferentes bairros.
- Compreender o comportamento dos anfitriões e os padrões de listagem.
- Detectar possíveis discrepâncias nos preços.
- Fornecer recomendações para hóspedes e anfitriões com base nos insights obtidos.

## 📂 Conjunto de Dados
O conjunto de dados contém **20.765 entradas e 22 colunas**, incluindo:

- `id` : Identificador único para cada listagem.
- `name` : Título do anúncio do Airbnb.
- `host_name` : Nome do anfitrião.
- `neighborhood_group` : Bairro onde a listagem está localizada.
- `latitude` / `longitude` : Geolocalização das listagens.
- `price` : Preço de aluguel por noite.
- `room_type` : Tipo de acomodação (ex: casa inteira, quarto privado).
- `reviews_per_month` : Média de avaliações mensais do anúncio.
- `availability_365` : Número de dias disponíveis no ano.

## 🔄 Etapas e Fluxo de Trabalho

### 1️⃣ Limpeza de Dados
- **Lidar com dados ausentes**: Colunas `price`, `neighborhood` e `beds` tinham valores nulos.
- **Correção de tipos de dados**: A coluna `last_review` foi convertida para um formato de data.
- **Remoção de outliers**: Listagens com preços acima de **US$ 1.500** foram limitadas para evitar distorções na visualização.

### 2️⃣ Análise Exploratória de Dados (EDA)

📌 **Distribuição do Tipo de Quarto**
- Visualização da contagem de cada tipo de acomodação com gráficos de barras.
- Identificação de **casas/apartamentos inteiros** como o tipo mais comum.

📌 **Variações de Preços por Bairro**
- Análise das diferenças de preços entre bairros.
- **Manhattan tem os preços médios mais altos**.

📌 **Tendências de Disponibilidade**
- Mapas de calor mostrando a correlação entre `price`, `availability_365` e `reviews_per_month`.

📌 **Distribuição de Preços**
- Histogramas utilizados para visualizar a dispersão dos preços.
- A maioria das listagens tem preços entre **US$ 50 e US$ 300**.

📌 **Padrões de Avaliações**
- Uso de gráficos de dispersão para explorar relações entre número de avaliações, preço e disponibilidade.

### 3️⃣ Visualização de Dados
- **Pairplot**: Correlações entre `price`, `availability_365` e `reviews_per_month`.
- **Mapa de calor**: Análise das correlações entre características numéricas.
- **Histogramas e Boxplots**: Detecção de outliers nos preços.
- **Gráficos de barras**: Distribuição dos tipos de quartos e bairros.

## 🔍 Principais Descobertas e Insights

📌 **Tendências de Preços**
- **Manhattan** tem os imóveis mais caros, seguido pelo Brooklyn.
- Casas/apartamentos inteiros são significativamente mais caros que quartos privados.

📌 **Distribuição do Tipo de Quarto**
- Casas/apartamentos inteiros dominam as listagens, mas quartos privados são opções mais acessíveis.

📌 **Outliers de Preço**
- Algumas listagens ultrapassam **US$ 1.500**, sugerindo necessidade de filtragem para análise confiável.

📌 **Padrões de Disponibilidade**
- Anúncios com alta disponibilidade tendem a ter preços mais baixos e mais avaliações.

## 🛠 Tecnologias Utilizadas
- **Python**
- **Pandas**
- **Numpy**
- **Matplotlib**
- **Seaborn**

## 📌 Próximos Passos
- Criar um modelo de Machine Learning para prever preços de novas listagens.
- Desenvolver um dashboard interativo com Plotly ou Power BI.
- Aplicar técnicas avançadas de visualização para insights mais profundos.

---
📢 Se você gostou do projeto, fique à vontade para contribuir ou dar sugestões! 🚀

