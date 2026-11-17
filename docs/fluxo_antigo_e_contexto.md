# Como funciona o fluxo do sistema de Registro de Demandas do Ensino.
---
## Feito com

Google AppScript no ? email da direção de ensino ?.

---
## O que é

Formulário feito no Google Forms. Usa scripts para processamento dos dados e envio de informações.

---
## Por que ele existe?

Algumas situações podem ocorrer, como por exemplo: aluno quebrou uma janela; aluno precisou sair fora de horário de aula; professor precisa se ausentar por motivo de saúde ou entre outras demadas. Quando algo nesse sentido acontece, algum servidor do campus registra a demanda no formulário.

---
# O que é preenchido, quais os campos? 

- Sobre quem é essa demanda (que aluno, o nome - string) 
- O vínculo dessa pessoa (Aluno, Professor, Técnico, Pai ou responsável ou outro - opções únicas)
- Curso da pessoa na resposta anterior (EMI Administração, EMI Informática, Sub Adm, Sub Tur, Sub Multimeios, Superior ADS, Superior Letras, Superior Matemática, Superior TPG ou Pós-graduação - opções únicas)
- Demanda solicita por (nome - string)
- Vínculo dessa pessoa (Aluno, Professor, Técnico, Pai ou responsável ou outro - opções únicas)
- Curso dessa mesma pessoa (EMI Administração, EMI Informática, Sub Adm, Sub Tur, Sub Multimeios, Superior ADS, Superior Letras, Superior Matemática, Superior TPG ou Pós-graduação - opções únicas)
- Email ou telefone do demandante
- Data da ocorrência da demanda.
- Tipo de demanda (chegada atrasada, saída antecipada, gazeando aula, uso indevido do celular, acolhimento, sugestão, reclamação, notificação ou outro - opções únicas)
- Descrição da demanda (string)
- Enviar demanda para (Coordenação de Ensino, Direção de Ensino, Coordenação Pedagógica, Coordenaria de Assistência Estudantil, Coordenação do NAPNE, Professora do AEE, Psicóloga ou outro - opções únicas)
- Upload de foto do formulário (versão física do formulário de demanda - .png, jpg ou pdf)

---
## O que acontece após o envio?

É importante destacarmos que esse formulário só permite envio por usuários Google autenticados que possuam emails '@osorio.ifrs.edu.br', logo esse é o padrão de segurança adotado para evitar respostas indesejadas. 
Voltando, ao enviar o formulário totalmente preenchido, um fluxo escrito na plataforma **Google AppScript** entra em ação. É analisado o campo 'Enviar demanda para': cada uma dessas chaves é associada à um email em específico, nesse cenário a script envia um email contendo todas as informações preenchidas para o setor indicado. 
Ao mesmo passo, existe uma painel administrativo, criado com a mesma ferramenta, ao qual é alimentado quando é disparado o envio do formulário. Nesse painel, há alguns usuários (emails) cadastrados pelo administrador. Cada usuário possui um escopo denominado setor e pode interagir com os dados daquela denominação, o que significa dizer que o usuário X pode ser cadastrado para o setor pedagógico e este poderá ver os dados dos envios marcados para o pedagógico. Esse painel conta com: listagem/histórico de envios, permitindo ler as informações de um envio, tratar do assunto com um comentário, enviar para um outro setor ou encerrar a demanda; dashboards das demandas por setor com gráficos de coluna comparativos entre os tipos de solicitação.

---
## O que queremos melhorar

Queremos reconstruir esse processo sem depender de um formulário, mas sim utilizar uma plataforma no formato de site para solicitação, acompanhamento e resolução da demanda.
O sistema construído não possui falhas estruturais, mas mesmo assim pode ser melhorado. Foram levantados alguns pontos de melhoria: 
- Acompanhamento da solicitação: ao realizar o envio, o servidor é notificado apenas por emails, ele não possui conhecimento em tempo real do tratamento do seu caso.
- Falta de rastreio entre os setores: um setor não enxerga facilmente o caminho que a demanda percorreu: caso a demanda percorra por 3 setores diferentes, o terceiro setor não tem acesso fácil a quem contribuiu com a solicitação.
- Tratamento de **edge cases**: caso seja realizado um envio para o setor incorreto, caso seja realizado um envio para um setor não listado são exemplos de casos de borda não compreendidos pelo fluxo atual.
- Dificuldade de novas features: por se tratar de uma ferramenta Google, é preciso possuir acesso à conta dona do código para produzir novas features. Além disso, o Google AppScript delimita o uso apenas para .html e .gs (js like), logo não é possível criar um reposítorio git pela plataforma, por exemplo.