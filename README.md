# 📚 Sistema de Biblioteca – Banco de Dados

Este projeto consiste na modelagem e implementação de um banco de dados relacional para um **Sistema de Biblioteca**, desenvolvido como parte da disciplina de Administração de Banco de Dados. O objetivo é aplicar, na prática, conceitos fundamentais de modelagem, integridade e manipulação de dados utilizando o Microsoft SQL Server.

---

## 📖 Sobre o Projeto

O sistema foi projetado para gerenciar informações relacionadas a autores, livros, usuários e empréstimos, garantindo a integridade e a consistência dos dados. A implementação foi realizada utilizando o **Microsoft SQL Server**, com suporte do **SQL Server Management Studio (SSMS)**.

Este projeto contempla boas práticas de desenvolvimento em banco de dados, incluindo a utilização de chaves primárias e estrangeiras, restrições de integridade, triggers e controle de transações.

---

## 🎯 Objetivos

- Modelar um banco de dados relacional completo;
- Garantir a integridade e a consistência dos dados;
- Implementar regras de negócio em nível de banco de dados;
- Aplicar comandos SQL para manipulação e consulta de dados;
- Utilizar recursos avançados do SQL Server;
- Documentar o processo de desenvolvimento.

---

## 🗂️ Estrutura do Banco de Dados

O sistema é composto por quatro entidades principais:

| Tabela       | Descrição |
|--------------|-----------|
| **Autores**      | Armazena informações sobre os autores dos livros |
| **Livros**       | Contém os dados do acervo da biblioteca |
| **Usuarios**     | Registra os usuários do sistema |
| **Emprestimos**  | Controla os empréstimos e devoluções |

---

## 🔗 Relacionamentos

- Um **autor** pode escrever vários **livros** (1:N).
- Um **livro** pertence a um único **autor**.
- Um **usuário** pode realizar vários **empréstimos** (1:N).
- Um **livro** não pode ser emprestado simultaneamente a mais de um usuário.

---

## 🛠️ Tecnologias Utilizadas

- **Microsoft SQL Server**
- **SQL Server Management Studio (SSMS)**
- **SQL (Structured Query Language)**
- **Draw.io / BRModelo** (Modelagem do DER)
- **Git e GitHub**

---

## 📊 Recursos Implementados

✔ Criação de banco de dados e tabelas  
✔ Chaves primárias e estrangeiras  
✔ Restrições de integridade (`NOT NULL`, `UNIQUE`, `CHECK`, `DEFAULT`)  
✔ Integridade referencial  
✔ Trigger para controle de empréstimos  
✔ Stored Procedure para automação de processos  
✔ Controle de transações (`COMMIT` e `ROLLBACK`)  
✔ Inserção, atualização e exclusão de dados  
✔ Diagrama Entidade-Relacionamento (DER)

## 🚀 Como Executar o Projeto

### 1️⃣ Clonar o Repositório
```bash
git clone https://github.com/seu-usuario/sistema-biblioteca-bd.git

## 📁 Estrutura do Repositório
