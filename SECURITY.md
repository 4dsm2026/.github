# Segurança

## Como relatar uma vulnerabilidade

**Não abra uma issue pública** para:

- senha, token, chave de API ou `.env` real exposto no código ou no histórico;
- falha que permita acessar dados de outro usuário ou agir como outro perfil (ex.: aluno acessando rotas de administrador);
- qualquer falha que possa ser explorada agora.

Use o relato privado do GitHub: na aba **Security** do repositório, clique em **Report a vulnerability**. Só os administradores da organização veem o relato.

Inclua: o que é possível fazer, os passos para reproduzir e os arquivos ou rotas envolvidos.

## O que pode ser issue pública

Melhorias de segurança sem risco imediato — dependência desatualizada, cabeçalho HTTP faltando, validação que poderia ser mais rígida — podem ser abertas normalmente como `[Security]`, seguindo o [guia de contribuição](CONTRIBUTING.md).

## Se um segredo vazou

1. Avise o professor imediatamente.
2. **Troque o segredo** (gere uma nova chave, senha ou token). Apagar o arquivo não basta: o valor continua no histórico do git.
3. Depois, remova o arquivo do repositório e adicione-o ao `.gitignore`.

Os hooks do repositório (veja o guia) bloqueiam commits de arquivos `.env`.
