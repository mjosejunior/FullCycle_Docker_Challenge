# Etapa de compilação
FROM golang:alpine AS builder

# Define o diretório de trabalho
WORKDIR /app

# Copia os arquivos go.mod e go.sum
# Estes arquivos definem as dependências do projeto
COPY go.mod .

# Baixa as dependências
RUN go mod download

# Copia os arquivos de código fonte
COPY . .

# Compila o programa
RUN CGO_ENABLED=0 GOOS=linux go build -o main .

# Etapa de execução
FROM scratch

# Copia o binário do estágio de compilação para o estágio de execução
COPY --from=builder /app/main /

# Executa o binário
CMD ["/main"]
