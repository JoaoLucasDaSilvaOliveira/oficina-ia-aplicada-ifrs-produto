# Requisitos funcionais — Demandas do Ensino

Os campos, tipos de resposta e obrigatoriedades são fixos. As opções dos campos de seleção descritas abaixo são as iniciais e podem ser administradas conforme RF-20.

## RF-01 — Registrar demanda

O sistema deve permitir registrar uma demanda com pessoa envolvida, solicitante, data do ocorrido, data de envio, tipo, descrição e destino.

**História:** US-01.

## RF-02 — Validar campos obrigatórios

O sistema deve exigir nome e vínculo da pessoa envolvida, nome completo e vínculo do solicitante, tipo, descrição e destino. Os cursos da pessoa envolvida e do solicitante e o contato do solicitante são opcionais, conforme os formulários.

**História:** US-01.

## RF-03 — Selecionar tipo e destino

O sistema deve permitir selecionar um tipo e um destino por demanda, usando as opções dos formulários.

**História:** US-01.

## RF-04 — Descrever a opção “Outro”

O sistema deve exigir descrição ao selecionar “Outro” em vínculo ou tipo.

**História:** US-01.

## RF-05 — Informar dados da pessoa

O sistema deve registrar separadamente o nome e o vínculo da pessoa envolvida e do solicitante, diretamente na demanda. Para cada pessoa, o sistema deve permitir selecionar um único vínculo: Aluno, Professor, Técnico, Pai ou responsável ou Outro, com descrição obrigatória para Outro. O sistema não deve exigir matrícula, cadastro prévio de estudante ou associação entre demandas.

**História:** US-01.

## RF-06 — Abrir demanda

O sistema deve criar a demanda na situação aberta.

**História:** US-01.

## RF-07 — Anexar documentos

O sistema deve permitir registrar a demanda sem anexos ou com até cinco fotos ou PDFs, de até 10 MB cada. O sistema deve recusar arquivos que ultrapassem esses limites.

**História:** US-02.

## RF-08 — Consultar anexos

O sistema deve permitir consultar os documentos anexados à demanda, respeitando as permissões que serão definidas com a plateia.

**História:** US-02, US-03.

## RF-09 — Consultar demandas

O sistema deve permitir listar e consultar os dados de demandas abertas e concluídas na plataforma.

**História:** US-03.

## RF-10 — Descrever a solução e concluir

O sistema deve disponibilizar uma única caixa de texto para descrição da solução e permitir concluir a demanda mesmo sem preenchê-la. O sistema não deve permitir reabrir uma demanda concluída.

**História:** US-04.

## RF-11 — Preservar demandas concluídas

O sistema deve preservar as demandas concluídas para consulta, sem oferecer exclusão de demandas.

**História:** US-04.

## RF-12 — Visualizar distribuição de demandas

O sistema deve apresentar a quantidade de demandas por destino e tipo, conforme os filtros aplicados. Sem filtros, o sistema deve considerar todas as demandas permitidas para consulta.

**História:** US-10.

## RF-13 — Consultar ocorrências

O sistema deve permitir consultar as ocorrências com os dados informados na demanda, para análise humana, sem classificação automática de recorrência.

**História:** US-11.

## RF-14 — Registrar datas

O sistema deve preencher automaticamente a data de envio com a data atual do sistema ao enviar a demanda. O sistema deve permitir informar separadamente a data do ocorrido, que é opcional, e impedir que ela seja futura.

**História:** US-01.

## RF-15 — Buscar e filtrar demandas

O sistema deve permitir busca pelo nome informado e filtros por situação, tipo, destino, período do ocorrido e período de envio.

**História:** US-03, US-11.

## RF-16 — Ordenar demandas

O sistema deve listar, sem filtros, todas as demandas permitidas para consulta, ordenadas pela data de envio, da mais recente para a mais antiga.

**História:** US-03.

## RF-17 — Informar mensagem de encaminhamento

O sistema deve apresentar, ao encaminhar a demanda a outro setor, uma caixa de texto opcional para a mensagem de encaminhamento. O encaminhamento não deve concluir a demanda.

**História:** US-05.

## RF-18 — Exibir demandas sem data do ocorrido

O sistema deve manter, ao filtrar por data do ocorrido, as demandas sem essa data (NULL) no final da lista.

**História:** US-03, US-11.

## RF-19 — Selecionar curso

O sistema deve permitir selecionar, opcionalmente e separadamente para a pessoa envolvida e para o solicitante, um único curso: EMI Administração, EMI Informática, Sub Adm, Sub Tur, Sub Multimeios, Superior ADS, Superior Letras, Superior Matemática, Superior TPG ou Pós-graduação.

**História:** US-01.

## RF-20 — Administrar opções

O sistema deve permitir ao administrador criar, alterar e remover opções dos campos de seleção, incluindo vínculo, curso, tipo de demanda e destino, sem alteração de código pela equipe de desenvolvimento. O sistema deve aplicar essas mudanças apenas a novos envios, preservando as opções e respostas das demandas já enviadas. O sistema deve impedir a criação, remoção ou alteração dos campos definidos em [fluxo antigo e contexto](fluxo_antigo_e_contexto.md), de seus tipos de resposta e de sua obrigatoriedade. A data de envio e a situação devem permanecer controladas pelo sistema.

**História:** US-13.

## RF-21 — Autenticar acesso institucional

O sistema deve exigir autenticação com uma conta cujo e-mail verificado pertença ao domínio `osorio.ifrs.edu.br` para acessar a plataforma e enviar demandas. O sistema deve recusar acesso anônimo ou com conta de outro domínio.

**História:** US-14.

## RF-22 — Disponibilizar painel administrativo e de atendimento

O sistema deve disponibilizar um painel com listagem e detalhes das demandas, descrição da solução, conclusão, encaminhamento e indicadores. O sistema deve disponibilizar nesse painel a administração de usuários, setores de atuação e opções do formulário apenas para administradores. As demais funcionalidades devem respeitar as permissões que serão detalhadas com a plateia.

**História:** US-03, US-04, US-05, US-09, US-10, US-13, US-15.

## RF-23 — Cadastrar acessos ao painel

O sistema deve permitir ao administrador cadastrar usuários do painel por e-mail institucional e associá-los a um ou mais setores de atuação. O sistema deve exigir esse cadastro para acesso às funções de atendimento do painel; possuir um e-mail institucional não deve conceder automaticamente acesso a essas funções ou à administração.

**História:** US-09, US-15.
