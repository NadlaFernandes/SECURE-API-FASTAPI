from fastapi import FastAPI, HTTPException
from pydantic import BaseModel

app = FastAPI(
    title="SecureAPI - Python & FastAPI",
    description="API desenvolvida com foco em conteinerização segura e boas práticas de nuvem.",
    version="1.0.0"
)

class HealthCheck(BaseModel):
    status: str
    environment: str

@app.get("/", tags=["Root"])
def read_root():
    return {
        "message": "API rodando com sucesso!",
        "status": "online",
        "security_mode": "active"
    }

@app.get("/health", response_model=HealthCheck, tags=["Monitoramento"])
def health_check():
    return {
        "status": "healthy",
        "environment": "development"
    }