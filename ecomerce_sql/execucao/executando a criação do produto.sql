-- EXECUTANDO A CRIAÇAO DE PRODUTO

-- cadastrando o produtuo
CALL proc_cadastrar_produtos(
0, -- 0 quando deseja inserir um novo produto, maior que 0 quando se deseja modificar o produto
'Mochila Dell Gaming 17', 
'Mantenha seu laptop para jogos em segurança enquanto estiver em movimento com a Mochila Dell Gaming',
250.58,
100
);

CALL proc_cadastrar_produtos(
0, 
'HEADSET GAMER ALIENWARE 7.1 | AW510H', 
'Seja envolvido pelos sons dos jogos usando o Alienware 7.1 Gaming Headset, que oferece som surround 7.1 com a tecnologia de áudio imersivo da Alienware.',
899.00,
50
);

CALL proc_cadastrar_produtos(
0, 
'Monitor 165Hz Gamer 27" Dell S2721DGF', 
'Monitor Gamer QHD de 27". As taxas de atualização de 165 Hz, tempo de resposta real de 1 ms GtG e o novo design de refrigeração oferecem jogabilidade ágil e com grande capacidade de resposta.',
5000.00,
50
);


CALL proc_cadastrar_produtos(
0, 
'Combo Teclado e Mouse Gamer Com Fio Detalhes Azuis Multilaser - TC195', 
'O teclado conta com 10 teclas multimídia com opção de troca por teclas direcionais transparentes extras, que darão melhor visibilidade para dar mais ritmo e performance ao seu jogo; se você procura conforto, este é o produto ideal.',
99.00,
100
);

CALL proc_cadastrar_produtos(
0, 
'CPC Gamer Completo AMD 6-Core CPU 3.8Ghz 8GB (Placa de vídeo Radeon R5 2GB) SSD 120GB Skill Monitor HDMI LED 19.5', 
'PC Gamer Completo AMD 6-Core CPU 3.8Ghz 8GB (Placa de vídeo Radeon R5 2GB) SSD 120GB Skill Monitor HDMI LED 19.5.',
1995.00,
50
);

CALL proc_cadastrar_produtos(
0, 
'Mesa de Canto em L Para Escritório com 2 Gavetas e 3 Portas NT2005 Notável Móveis', 
'Versátil e espaçosa a Mesa Office NT2005 da Notável Móveis, oferece para você um local de trabalho ou estudo que permite organizar melhor seus objetos de uso diário, e ela se adequa a sua necessidade, pois o gaveteiro pode ser monta.',
450.5,
50
);

-- REALIZANDO A CONSULTA 
SELECT * FROM produtos;

-- MODIIFCNAOD O PRODUTO 
-- CASO QUEIRA MODIFICAR, BASTA NO LUGAR DO 0 COLOCAR O ID DO PRODUTO E PREENCHER AS INFORMAÇÕES DELE
/*
CALL proc_cadastrar_produtos(
2, 
'teclado com fio', 
'teclado com fio da microsoft',
39.99,
25
);
*/