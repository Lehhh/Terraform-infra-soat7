module "prod" {
  source = "../../infra"
  nome_repositorio = "producao"
  cargoIAM = "producao"
  ambiente = "producao"
  ecr_app_image = "539992599162.dkr.ecr.us-east-1.amazonaws.com/soat7-lanchonete:1.0.1"
  app_name = "lanchonete-soat7"
}
