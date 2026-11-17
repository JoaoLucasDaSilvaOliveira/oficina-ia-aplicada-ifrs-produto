# Requisitos não funcionais — Demandas do Ensino

## RNF-01 — Adaptar a interface aos dispositivos

O sistema deve adaptar sua interface para uso em computadores e celulares, com prioridade para o uso em computador.

## RNF-02 — Limitar o tempo de consultas leves

O sistema deve concluir consultas leves, como a listagem de demandas, em até 3 segundos, medidos desde a ação na interface até a apresentação do resultado. O sistema deve registrar separadamente os atrasos das ferramentas utilizadas, como o banco de dados, quando justificarem uma exceção a esse limite.

## RNF-03 — Limitar o tempo das demais operações

O sistema deve concluir requisições pesadas e demais ações em até 5 segundos, medidos desde a ação na interface até a apresentação do resultado. O sistema deve registrar separadamente os atrasos das ferramentas utilizadas, como o banco de dados, quando justificarem uma exceção a esse limite.

## RNF-04 — Preservar o preenchimento após falhas

O sistema deve preservar os campos preenchidos na tela quando o envio falhar, informar a falha e permitir nova tentativa. O sistema deve confirmar o envio somente após salvar os dados.

## RNF-05 — Garantir acessibilidade na interação

O sistema deve permitir navegação por teclado, apresentar rótulos nos campos e foco visível e comunicar informações e erros sem depender apenas de cores.

## RNF-06 — Permitir aumento de fonte

O sistema deve oferecer uma opção de aumento do tamanho da fonte até 200% do tamanho original, sem perda de conteúdo ou funcionalidade e mantendo campos e botões utilizáveis.

## RNF-07 — Validar autenticação e autorização no servidor

O sistema deve validar a identidade autenticada, o domínio exato `osorio.ifrs.edu.br` e as permissões no servidor em cada operação protegida, incluindo acesso a anexos. O sistema não deve aceitar um e-mail apenas digitado como prova de identidade nem depender exclusivamente de controles na interface para restringir o acesso.
