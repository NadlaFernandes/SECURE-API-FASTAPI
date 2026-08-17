# 1. Imagem base oficial do Python enxuta (Debian Slim)
FROM python:3.11-slim

# 2. Define variáveis de ambiente para otimizar o Python no container
ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1

# 3. Define o diretório de trabalho dentro do container
WORKDIR /app

# 4. PRÁTICA DE SEGURANÇA: Cria um usuário sem privilégios de root
RUN adduser --disabled-password --gecos "" appuser

# 5. Copia e instala as dependências
COPY requirements.txt .
RUN pip install --no-cache-dir --upgrade -r requirements.txt

# 6. Copia o código da aplicação
COPY src/ ./src/

# 7. PRÁTICA DE SEGURANÇA: Ajusta as permissões da pasta e altera para o usuário sem root
RUN chown -R appuser:appuser /app
USER appuser

# 8. Expõe a porta que a aplicação vai rodar
EXPOSE 8000

# 9. Comando para rodar a aplicação com Uvicorn
CMD ["uvicorn", "src.main:app", "--host", "0.0.0.0", "--port", "8000"]