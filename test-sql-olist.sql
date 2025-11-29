SELECT * FROM customer c LIMIT 10


--Cod 02
SELECT
    p.product_id,
    p.product_category_name
FROM
    products p
WHERE
    p.product_category_name = 'perfumaria';

--Cod 03 ID do cliente, cidade e estado até as 10 primeiras linhas
SELECT
   c.customer_id,
   c.customer_city,
   c.customer_state
FROM customer c
LIMIT 10

--Cod 04 ID do cliente e cidade, somente de SC
SELECT
   c.customer_id,
   c.customer_city
FROM customer c
WHERE c.customer_state = 'SC'
LIMIT 10

--Cod 05 Estado, latitude e logitude de SP
SELECT
   g.geolocation_lat,
   g.geolocation_lng,
   g.geolocation_state
FROM geolocation g
WHERE g.geolocation_state = 'SP'
LIMIT 10; --pode usar ; no final

--Cod 06 Tabela com ID do produto, data limite de envio e o preço somente de produtos R$ 6.300
SELECT
   oi.product_id, --oi é um apelido temporário dado a tabela
   oi.shipping_limit_date,
   oi.price
FROM order_items oi
WHERE oi.price > 6300

--Cod 07 Tabela com ID do pedido, tipo de pagamento e núemro de parcelas, somente produtos < R$ 1
SELECT
   op.order_id, --op é o apelido temporário
   op.payment_type,
   op.payment_installments
FROM order_payments op 
WHERE op.payment_installments < 1

--Cod 08 Tabela com ID do pedido e cliente, status e data aprovação, só compras até 05/10/2016
SELECT
   o.order_id,
   o.customer_id,
   o.order_status,
   o.order_approved_at
FROM orders o
WHERE o.order_approved_at <= '2016-10-05' -- atentar na ordem da data ano/mês/dia

--Cod 09 Número de clientes únicos de MG
SELECT
   COUNT (DISTINCT c.customer_id) --DISTINCT elimina linhas duplicadas, retornando apenas os valores únicos.
FROM customer c
WHERE c.customer_state = 'MG'

--Cod 10 Quantidade de cidades únicas dos vendedores de SC
SELECT
   COUNT (DISTINCT s.seller_city)
FROM sellers s
WHERE s.seller_state = 'SC'

--Cod 11 Quantidade de cidades únicas de todos os vendedores da base
SELECT
   COUNT (DISTINCT seller_city) -- colocar o "s.seller_city" também funciona
FROM sellers s

--Cod 12 Número total de pedidos acima de 3.500
SELECT
   COUNT (DISTINCT oi.order_id) -- sem o "oi" também funciona
FROM order_items oi
WHERE price > 3500

--Cod 13 Valor médio dos pedidos
SELECT
AVG( price )
FROM order_items oi

--Cod 14 Maior valor de preço entre os pedidos
SELECT
MAX( price )
FROM order_items oi

--Cod 15 Menor valor de preço entre todos os pedidos
SELECT
MIN( price )
FROM order_items oi

--Cod 20 Quantidade de produtos distintos vendidos abaixo de R$ 100,00
SELECT
COUNT( DISTINCT product_id )
FROM order_items oi
WHERE price < 100

--Cod 21 Quantidade de vendedors distintos que receberam algum pedido antes de 23/09/2016
SELECT
COUNT( DISTINCT seller_id )
FROM order_items oi
WHERE shipping_limit_date < '2016-09-23 00:00:00'

--Cod 22 tipos de pagamentos
SELECT
DISTINCT payment_type
FROM order_payments op

--Cod 23 Maior número de parcelas realizados
SELECT
MAX( payment_installments )
FROM order_payments op

--Cod 24 Menor número de parcelas realizadas
SELECT
MIN( payment_installments )
FROM order_payments op

--Cod 25 média do valor pago no cartão de crédito
SELECT
AVG( payment_value )
FROM order_payments op
WHERE payment_type = 'credit_card'

--Cod 26 status para um pedido
SELECT
COUNT( DISTINCT order_status )
FROM orders o

--Cod 27 tipos de status para um pedido
SELECT
DISTINCT order_status
FROM orders o

--Cod 28 clientes distintos fizeram um pedido
SELECT
COUNT( DISTINCT customer_id )
FROM orders o

--Cod 29 produtos cadastrados na empresa
SELECT
COUNT( DISTINCT product_id )
FROM products p

--Cod 30 quantidade máxima de fotos de um produto
SELECT
   MAX (product_photos_qty)
FROM products p

--Cod 31 maior valor de peso entre os produtos
SELECT
   MAX (DISTINCT product_weight_g)
FROM products p

--Cod 32 altura médio dos produtos
SELECT
   AVG (product_height_cm)
FROM products p

--Cod 33 agrupamento - resume um conjunto de dados em apenas um número
SELECT
p.product_category_name, --nesse não pode ficar sem a vírgula
COUNT( p.product_id )
FROM products p
GROUP BY p.product_category_name

--Cod 34
SELECT
p.product_category_name,
COUNT( p.product_id ),
SUM( p.product_weight_g ),
AVG( p.product_weight_g ),
MAX( p.product_height_cm ),
MIN( p.product_width_cm ),
COUNT( DISTINCT p.product_length_cm )
FROM products p
GROUP BY p.product_category_name --GROUP BY indica a coluna/dimensão do agrupamento, funciona como uma tabela dinâmica

--Cod 35 agrupamento com uma variável
SELECT
oi.seller_id ,
COUNT( DISTINCT oi.order_id ) AS pedidos,
COUNT( oi.product_id ) AS items,
AVG( oi.price ) AS preco_medio --ignora qualquer valor NULL
FROM order_items oi
GROUP BY oi.seller_id

--Cod 36 agrupamento com 2 variáveis/dimensões
SELECT
s.seller_state ,
s.seller_city,
COUNT( s.seller_id ),
SUM( s.seller_zip_code_prefix )
FROM sellers s
GROUP BY s.seller_state , s.seller_city

--Cod 37
SELECT
DATE( oi.shipping_limit_date ) AS data_ ,
COUNT( oi.seller_id ) AS vendedores,
COUNT( DISTINCT oi.order_id ) AS pedidos,
COUNT( oi.product_id ) AS items,
AVG( oi.price ) AS preco_medio
FROM order_items oi
GROUP BY DATE( oi.shipping_limit_date )

--Cod 38 Número de clientes únicos de todos os estados
SELECT
c.customer_state ,
COUNT( DISTINCT c.customer_id ) AS numero_clientes
FROM customer c
GROUP BY c.customer_state

--Cod 39 número de cidades únicas dos clientes de todos os estados
SELECT
customer_state ,
COUNT( DISTINCT customer_city ) AS numero_cidades --AS cria uma alias, nome temporário e mais legível para uma coluna ou tabela, não altera o nome original
FROM customer c
GROUP BY customer_state

--Cod 40 núemro de clientes únicos por estado e cidade
SELECT
c.customer_state,
c.customer_city ,
COUNT( DISTINCT c.customer_id ) AS clientes
FROM customer c
GROUP BY c.customer_state , c.customer_city

--Cod 41 número de clientes únicos por cidade e estado
SELECT
c.customer_city ,
c.customer_state,
COUNT( DISTINCT c.customer_id ) AS clientes
FROM customer c
GROUP BY c.customer_city, c.customer_state

--Cod 42 número total de pedidos únicos por cada vendedor
SELECT
	seller_id,
COUNT( DISTINCT order_id )
FROM order_items oi
GROUP BY seller_id

--Cod 43 número total de pedidos únicos, data mínima e máxima de limite de envio, valor max, min e med do frete de cada vendedor
SELECT
	seller_id,
COUNT( DISTINCT order_id ) AS pedidos_unicos,
MIN( shipping_limit_date ) AS data_minima_envio,
MAX( shipping_limit_date ) AS data_maxima_envio,
AVG( freight_value ) AS valor_medio_frete_medio,
MIN( freight_value) AS valor_minimo_frete,
MAX( freight_value) AS valor_maximo_frete
FROM order_items oi
GROUP BY seller_id

--Cod 44 valor médio, máxim e mínimo do preço de todos os pedidos de cada produto
SELECT
	oi.product_id,
AVG( oi.price ) AS preco_medio,
MIN( oi.price ) AS preco_minimo,
MAX( oi.price ) AS preco_maximo
FROM order_items oi
GROUP BY oi.product_id

--Cod 45 quantidade de vendedores distintos que receberam algum pedido e preço médio das vendas
SELECT
COUNT( DISTINCT seller_id ) AS vendedores,
AVG( oi.price ) AS preco_medio
FROM order_items oi

--Cod 46 quantidade de pedidos por tipo de pagamento
SELECT
	payment_type,
COUNT( op.order_id ) as pedidos
FROM order_payments op
GROUP BY op.payment_type

--Cod 47 quantidade de pedidos, médio do valor de pagamento e o número de parcelas por tipo de pagamento
SELECT
	payment_type,
COUNT( op.order_id ) AS pedidos,
AVG( op.payment_value ) AS pagamento_medio,
MAX( op.payment_installments ) AS maior_numero_par
FROM order_payments op
GROUP BY op.payment_type

--Cod 48 valor min, mas, med e soma de pagamento por cada tipo de pagamento e nº de parcelas disponíveis
SELECT
	payment_type,
	payment_installments,
MIN( payment_value ) AS pagamento_minimo,
MAX( payment_value ) AS pagamento_maximo,
AVG( payment_value ) AS pagamento_medio,
SUM( payment_value ) AS pagamento_total
FROM order_payments op
GROUP BY payment_type, payment_installments

--Cod 49 média de preços de produtos
SELECT
	product_id,
AVG(price) AS avg_price
FROM order_items
GROUP BY product_id

--Cod 50 quantidade de pedidos por status
SELECT
count(order_id) as qtd_produtos, order_status
from orders
GROUP by order_status

--Cod 51 quantidade de pedidos realizados por dia
--DATE() converete de timestamp (data e hora) para data
SELECT
DATE( order_approved_at ) AS data_ ,
COUNT( order_id ) AS pedidos
FROM orders o
GROUP BY DATE( order_approved_at )

--Cod 52 quantidade de produtos cadastrados por categoria
SELECT
product_category_name,
COUNT( DISTINCT product_id ) AS produtos
FROM products p
GROUP BY product_category_name

--Cod 53 Todas as linhas cujo valor da coluna "product_category_name" seja igual a "audio"
SELECT
COUNT( p.product_id )
FROM products p
WHERE p.product_category_name = 'audio'

--Cod 54 Todas as linhas cujo valor da coluna "product_photos_qty" seja igual a "3"
SELECT
COUNT( p.product_id ) AS produtos
FROM products p
WHERE p.product_photos_qty = 3

--Cod 55 Todas as linhas cujo valor da coluna “product_category_name” seja diferente de “alimentos”.
SELECT
p.product_category_name ,
COUNT( p.product_id )
FROM products p
WHERE p.product_category_name <> 'alimentos'
GROUP BY p.product_category_name

--Cod 56 "Todas as linhas cujo valor da coluna “product_photos_qty” seja diferente de “3”."
SELECT
product_photos_qty,
COUNT( p.product_id ) AS produtos
FROM products p
WHERE p.product_photos_qty <> 3
GROUP BY p.product_photos_qty

--Cod 57 Todas as linhas cujo valor da coluna “product_photos_qty” seja maior que “3”.
SELECT
product_photos_qty,
COUNT( p.product_id ) AS produtos
FROM products p
WHERE p.product_photos_qty > 3
GROUP BY p.product_photos_qty

--Cod 58 Todas as linhas cujo valor da coluna “product_photos_qty” seja maior ou igual a “3”.
SELECT
product_photos_qty,
COUNT( p.product_id ) AS produtos
FROM products p
WHERE p.product_photos_qty >= 3
GROUP BY p.product_photos_qty

--Cod 59 Todas as linhas cujo valor da coluna “product_photos_qty” seja menor ou igual a “3”.
SELECT
product_photos_qty,
COUNT( p.product_id ) AS produtos
FROM products p
WHERE p.product_photos_qty <= 3
GROUP BY p.product_photos_qty

--Cod 60 Número de clientes únicos do estado de São Paulo
SELECT
COUNT( DISTINCT c.customer_id ) AS numero_clientes
FROM customer c
WHERE c.customer_state = 'SP'

--Cod 61 Número total de pedidos únicos feitos no dia 08 de Outubro de 2016
SELECT
COUNT( DISTINCT order_id )
FROM orders o
WHERE DATE( order_purchase_timestamp ) = '2016-10-08'

--Cod 62 Número total de pedidos únicos feitos a partir do dia 08 de Outubro de 2016
SELECT
COUNT( DISTINCT order_id )
FROM orders o
WHERE DATE( order_purchase_timestamp ) > '2016-10-08'

--Cod 63 Número total de pedidos únicos feitos com a data limite de envio, a partir do dia 08 de Outubro de 2016 incluso
SELECT
COUNT( DISTINCT order_id )
FROM order_items oi
WHERE DATE( shipping_limit_date ) >= '2016-10-08'

--Cod 64 Número total de pedidos únicos e o valor médio do frete para pedidos com valor abaixo de R$ 1.100
SELECT
COUNT( DISTINCT order_id ) AS pedidos_unicos,
AVG( freight_value ) AS valor_frete_medio
FROM order_items oi
WHERE price < 1100

--Cod 65 nº total de pedidos únicos, data mínima e máxima de limite de envio, valores máx, mín e méd do frete para pedidos com valor abaixo de R$ 1.100, agrupados por cada vendedor
SELECT
oi.seller_id as VENDEDOR,
COUNT(DISTINCT oi.order_id) as TOTAL_PEDIDOS,
MIN(oi.shipping_limit_date) as DT_MIN_ENVIO,
MAX(oi.shipping_limit_date) as DT_MAX_ENVIO,
MAX(oi.freight_value) as VL_MAX_FRETE,
MIN(oi.freight_value) as VL_MIN_FRETE,
AVG(oi.freight_value) as VL_MEDIO_FRETE
FROM order_items oi
WHERE oi.price <= 1100
GROUP BY oi.seller_id

--Cod 66 
SELECT
COUNT( p.product_id )
FROM products p
WHERE p.product_category_name = 'audio'
AND p.product_photos_qty >= 3
AND p.product_photos_qty < 10

--Cod 67 
SELECT
COUNT( p.product_id )
FROM products p
WHERE p.product_category_name = 'audio'
OR p.product_photos_qty >= 3

--Cod 68 Número de clientes únicos nos estado de Minas Gerais ou Rio de Janeiro
SELECT
customer_state,
COUNT( DISTINCT c.customer_id ) AS cliente_unico
FROM customer c
WHERE c.customer_state = 'MG' OR c.customer_state = 'RJ'
GROUP BY customer_state

--Cod 69 Quantidade de cidades únicas dos vendedores de São Paulo ou Rio de Janeiro com a latitude maior que -24.54 e longitude menor que -45.63
SELECT
g.geolocation_state,
COUNT(DISTINCT g.geolocation_city) AS cidades_unic
FROM
geolocation g
WHERE
(g.geolocation_state = 'SP'
OR g.geolocation_state = 'RJ')
AND g.geolocation_lat > -24.54
AND g.geolocation_lng < -45.63
GROUP BY g.geolocation_state;

--Cod 70 nº total de pedidos únicos, o nº total de produtos e o preço médio dos pedidos com o preço de frete maior que R$ 20 e a data limite de envio entre os dias 1 e 31 de Outubro de 2016
--OBS: Use a função DATE( ) para converter a data no formato timestamp (data e hora) para data.
SELECT
COUNT(DISTINCT oi.order_id) AS pedidos,
COUNT(oi.product_id) AS produtos,
AVG(oi.price) AS preco_medio
FROM
order_items oi
WHERE
oi.freight_value > 20
AND DATE(oi.shipping_limit_date) >= '2016-10-01'
AND DATE(oi.shipping_limit_date) <= '2016-10-31';

--Cod 71 Quantidade total dos pedidos e o valor total do pagamento, para pagamentos entre 1 e 5 prestações ou um valor de pagamento acima de R$ 5000. Agrupado por quantidade de prestações.
SELECT
    op.payment_installments AS qtd_parcelas,
    COUNT(DISTINCT op.order_id) AS pedidos,
    SUM(op.payment_value) AS valor_total_pagamento
FROM order_payments AS op
WHERE
    (op.payment_installments BETWEEN 1 AND 5)
    OR (op.payment_value > 5000)
GROUP BY
    op.payment_installments
ORDER BY
    qtd_parcelas;


--Cod 72 Quantidade de pedidos com o status em processamento ou cancelada acontecem com a data estimada de entrega maior que 01 de Janeiro de 2017 ou menor que 23 de Novembro de 2016
SELECT
    o.order_status,
    COUNT(DISTINCT o.order_id) AS pedidos
FROM orders AS o
WHERE
    o.order_status IN ('processing', 'canceled')
    AND (
        date(o.order_estimated_delivery_date) > date('2017-01-01')
        OR date(o.order_estimated_delivery_date) < date('2016-11-23')
    )
GROUP BY
    o.order_status
ORDER BY
    o.order_status;

--Cod 73 Quantidade de produtos estão cadastrados nas categorias: perfumaria, brinquedos, esporte lazer, cama mesa e banho e móveis de escritório que possuem mais de 5 fotos, um peso maior que 5 g, um altura maior que 10 cm, uma largura maior que 20 cm
SELECT
    p.product_category_name,
    COUNT(DISTINCT p.product_id) AS qtde_produtos
FROM products AS p
WHERE
    p.product_category_name IN (
        'perfumaria',
        'brinquedos',
        'esporte_lazer',
        'cama_mesa_banho',
        'moveis_escritorio'
    )
    AND p.product_photos_qty > 5
    AND p.product_weight_g > 5
    AND p.product_height_cm > 10
    AND p.product_width_cm > 20
GROUP BY
    p.product_category_name
ORDER BY
    p.product_category_name;

--Cod 74 O operador BETWEEN é uma alternativa para múltiplas condicionais AND.
SELECT
COUNT( p.product_id )
FROM products p
WHERE p.product_category_name = 'audio'
AND p.product_photos_qty NOT BETWEEN 3 AND 10

--Cod 75 Filtra qualquer linha da tabela “products” onde o valor da coluna “product_category_name” comece com o caracter “a”, independente dos outros caracteres da palavra.
SELECT
p.product_category_name,
COUNT( p.product_id ) AS produtos
FROM products p
WHERE p.product_category_name LIKE 'a%'
GROUP BY p.product_category_name

--Cod 76 "Filtra qualquer linha da tabela “products” onde o valor da coluna “product_category_name” comece com “a”, tenha um caracter “s” no meio e termine com “o”, independente dos outros caracteres da palavra
SELECT
p.product_category_name,
COUNT( p.product_id ) AS produtos
FROM products p
WHERE p.product_category_name LIKE 'a%s%o'
GROUP BY p.product_category_name

--Cod 77 Quantidade de clientes únicos tiveram seu pedidos com status de “processing”, “shipped” e “delivered”, feitos entre os dias 01 e 31 de Outubro de 2016. Mostrar o resultado somente se o número total de clientes for acima de 5.
WITH filtered AS (
    SELECT
        o.order_id,
        o.customer_id,
        o.order_status
    FROM orders AS o
    WHERE
        date(o.order_purchase_timestamp) BETWEEN date('2016-10-01') AND date('2016-10-31')
        AND o.order_status IN ('processing', 'shipped', 'delivered')
)
SELECT
    f.order_status,
    COUNT(DISTINCT f.customer_id) AS clientes_unicos
FROM filtered AS f
GROUP BY
    f.order_status
HAVING
    (
        SELECT COUNT(DISTINCT f2.customer_id)
        FROM filtered AS f2
    ) > 5
ORDER BY
    f.order_status;

--Cod 78 Quantos produtos estão cadastrados nas categorias: perfumaria, brinquedos, esporte lazer e cama mesa, que possuem entre 5 e 10 fotos, um peso que não está entre 1 e 5 g, um altura maior que 10 cm, uma largura maior que 20 cm. Mostra somente as linhas com mais de 10 produtos únicos.
SELECT
    p.product_category_name,
    COUNT(DISTINCT p.product_id) AS produtos_unicos
FROM products AS p
WHERE
    p.product_category_name IN ('perfumaria', 'brinquedos', 'esporte_lazer', 'cama_mesa_banho')
    AND p.product_photos_qty BETWEEN 5 AND 10
    AND p.product_weight_g NOT BETWEEN 1 AND 5
    AND p.product_height_cm > 10
    AND p.product_width_cm > 20
GROUP BY
    p.product_category_name
HAVING
    COUNT(DISTINCT p.product_id) > 10
ORDER BY
    p.product_category_name;

--Cod 79 Quantos produtos estão cadastrados em qualquer categorias que comece com a letra “a” e termine com a letra “o” e que possuem mais de 5 fotos? Mostrar as linhas com mais de 10 produtos.
SELECT
product_category_name ,
COUNT( DISTINCT product_id ) AS produto
FROM products p
WHERE product_category_name LIKE 'a%o'
AND product_photos_qty > 5
GROUP BY product_category_name
HAVING COUNT( DISTINCT product_id ) > 10

--Cod 80 O número de clientes únicos, agrupados por estado e por cidades que comecem com a letra “m”, tem a letra “o” e terminem com a letra “a”? Mostrar os resultados somente para o número de clientes únicos maior que 10.
SELECT
customer_state,
c.customer_city,
COUNT( DISTINCT c.customer_id ) AS cliente_unico
FROM customer c
WHERE c.customer_city LIKE 'm%o%a'
GROUP BY customer_state, customer_city
HAVING COUNT( DISTINCT c.customer_id ) > 10

--Cod 81 Gerar uma tabela de dados com 10 linhas, contendo o id do pedido, o id do cliente, o status do pedido, o id do produto e o preço do produto.
SELECT
    o.order_id,
    o.customer_id,
    o.order_status,
    oi.product_id,
    oi.price
FROM orders AS o
INNER JOIN order_items AS oi
    ON oi.order_id = o.order_id
ORDER BY
    o.order_id,
    oi.order_item_id
LIMIT 10;

--Cod 82 Gerar uma tabela de dados com 20 linhas, contendo o id do pedido, o estado do cliente, a cidade do cliente, o status do pedido, o id do produto e o preço do produto, somente para clientes do estado de São Paulo
SELECT
    o.order_id,
    c.customer_state,
    c.customer_city,
    o.order_status,
    oi.product_id,
    oi.price
FROM orders AS o
INNER JOIN customer AS c
    ON c.customer_id = o.customer_id
INNER JOIN order_items AS oi
    ON oi.order_id = o.order_id
WHERE
    c.customer_state = 'SP'
ORDER BY
    o.order_id,
    oi.order_item_id
LIMIT 20;

--Cod 83 Gerar uma tabela de dados com 50 linhas, contendo o id do pedido, o estado e a cidade do cliente, o status do pedido, o nome da categoria do produto e o preço do produto, somente para pedidos com o status igual a cancelado.
--Verificar todas as opções da coluna 'order_status'
SELECT
    o.order_id,
    c.customer_state,
    c.customer_city,
    o.order_status,
    p.product_category_name,
    oi.price
FROM orders AS o
INNER JOIN customer AS c
    ON c.customer_id = o.customer_id
INNER JOIN order_items AS oi
    ON oi.order_id = o.order_id
INNER JOIN products AS p
    ON p.product_id = oi.product_id
WHERE
    o.order_status = 'canceled'
ORDER BY
    o.order_id,
    oi.order_item_id
LIMIT 50;

--Cod 84 Gerar uma tabela de dados com 80 linhas, contendo o id do pedido, o estado e a cidade do cliente, o status do pedido, o nome da categoria do produto, o preço do produto, a cidade e o estado do vendedor e a data de aprovação do pedido, somente para os pedidos aprovadas a partir do dia 16 de Setembro de 2016.
SELECT
    o.order_id,
    c.customer_state,
    c.customer_city,
    o.order_status,
    p.product_category_name,
    oi.price,
    s.seller_city,
    s.seller_state,
    o.order_approved_at
FROM orders AS o
INNER JOIN customer AS c
    ON c.customer_id = o.customer_id
INNER JOIN order_items AS oi
    ON oi.order_id = o.order_id
INNER JOIN products AS p
    ON p.product_id = oi.product_id
INNER JOIN sellers AS s
    ON s.seller_id = oi.seller_id
WHERE
    o.order_approved_at IS NOT NULL
    AND date(o.order_approved_at) >= date('2016-09-16')
ORDER BY
    o.order_id,
    oi.order_item_id
LIMIT 80;

--Cod 85 Gerar uma tabela de dados com 10 linhas, contendo o id do pedido, o estado e a cidade do cliente, o status do pedido, o nome da categoria do produto, o preço do produto, a cidade e o estado do vendedor, a data de aprovação do pedido e o tipo de pagamento, somente para o tipo de pagamento igual a boleto.
SELECT
    o.order_id,
    c.customer_state,
    c.customer_city,
    o.order_status,
    p.product_category_name,
    oi.price,
    s.seller_city,
    s.seller_state,
    o.order_approved_at,
    op.payment_type
FROM orders AS o
INNER JOIN customer AS c
    ON c.customer_id = o.customer_id
INNER JOIN order_items AS oi
    ON oi.order_id = o.order_id
INNER JOIN products AS p
    ON p.product_id = oi.product_id
INNER JOIN sellers AS s
    ON s.seller_id = oi.seller_id
INNER JOIN order_payments AS op
    ON op.order_id = o.order_id
WHERE
    op.payment_type = 'boleto'
ORDER BY
    o.order_id,
    oi.order_item_id
LIMIT 10;

--Cod 86 "Gerar uma tabela de dados com 20 linhas e contendo as seguintes colunas: 
--1) Id do pedido, 
--2) status do pedido, 
--3) id do produto, 
--4) categoria do produto, 
--5) avaliação do pedido, 
--6) valor do pagamento, 
--7) tipo do pagamento, 
--8) cidade do vendedor, 
--9) latitude e longitude da cidade do vendedor."
WITH geo AS (
    SELECT
        g.geolocation_zip_code_prefix AS zip_prefix,
        AVG(g.geolocation_lat) AS geolocation_lat,
        AVG(g.geolocation_lng) AS geolocation_lng
    FROM geolocation AS g
    GROUP BY
        g.geolocation_zip_code_prefix
)
SELECT
    o.order_id,                      -- 1) Id do pedido
    o.order_status,                  -- 2) Status do pedido
    oi.product_id,                   -- 3) Id do produto
    p.product_category_name,         -- 4) Categoria do produto
    orv.review_score,                -- 5) Avaliação do pedido
    op.payment_value,                -- 6) Valor do pagamento
    op.payment_type,                 -- 7) Tipo do pagamento
    s.seller_city,                   -- 8) Cidade do vendedor
    geo.geolocation_lat,             -- 9) Latitude da cidade/CEP do vendedor
    geo.geolocation_lng              -- 9) Longitude da cidade/CEP do vendedor
FROM orders AS o
INNER JOIN order_items AS oi
    ON oi.order_id = o.order_id
LEFT JOIN products AS p
    ON p.product_id = oi.product_id
LEFT JOIN sellers AS s
    ON s.seller_id = oi.seller_id
LEFT JOIN geo
    ON geo.zip_prefix = s.seller_zip_code_prefix
LEFT JOIN order_reviews AS orv
    ON orv.order_id = o.order_id
LEFT JOIN order_payments AS op
    ON op.order_id = o.order_id
ORDER BY
    o.order_id,
    oi.order_item_id,
    op.payment_sequential
LIMIT 20;

--Cod 87 Quantos tipos de pagamentos foram usados pelo cliente para pagar o pedido 'e481f51cbdc54678b7cc49136f2d6af7’
SELECT
    op.payment_type,
    COUNT(*) AS ocorrencias
FROM order_payments AS op
WHERE
    op.order_id = 'e481f51cbdc54678b7cc49136f2d6af7'
GROUP BY
    op.payment_type
ORDER BY
    ocorrencias DESC, op.payment_type;

--Cod 88 Quantos pedidos tem mais de 5 items distintos
SELECT
    COUNT(*) AS qtde_pedidos
FROM (
    SELECT
        o.order_id
    FROM orders AS o
    INNER JOIN order_items AS oi
        ON oi.order_id = o.order_id
    GROUP BY
        o.order_id
    HAVING
        COUNT(DISTINCT oi.product_id) > 5
) AS t;

--Cod 89 Qual a cardinalidade entre a tabela Pedidos ( orders ) e Avaliações ( reviews )?
SELECT
    o.order_id,
    COUNT(r.review_id) AS qtd_reviews
FROM orders AS o
LEFT JOIN order_reviews AS r
    ON r.order_id = o.order_id
GROUP BY
    o.order_id
HAVING
    COUNT(r.review_id) > 1;

--Cod 90 Quantos pedidos (orders) não tem nenhuma avaliação (review)
SELECT
    COUNT(*) AS qtde_pedidos_sem_review
FROM orders AS o
LEFT JOIN order_reviews AS r
    ON r.order_id = o.order_id
WHERE
    r.order_id IS NULL;


--Cod 91 Quais são os top 10 vendedores com mais clientes
SELECT
    s.seller_id,
    COUNT(DISTINCT o.customer_id) AS total_clientes
FROM orders AS o
INNER JOIN order_items AS oi
    ON oi.order_id = o.order_id
INNER JOIN sellers AS s
    ON s.seller_id = oi.seller_id
INNER JOIN customer AS c
    ON c.customer_id = o.customer_id
GROUP BY
    s.seller_id
ORDER BY
    total_clientes DESC, s.seller_id
LIMIT 10;

--Cod 92 Quantos pedidos (orders) não possuem nenhum produto (products)
SELECT
    COUNT(*) AS qtde_pedidos_sem_itens
FROM orders AS o
WHERE NOT EXISTS (
    SELECT 1
    FROM order_items AS oi
    WHERE oi.order_id = o.order_id
);

--Cod 93 Montar a grande tabela da empresa Olist, a partir da união de todas as tabelas.
SELECT
    o.order_id,
    o.customer_id,
    o.order_status,
    oi.order_item_id,
    oi.product_id,
    oi.seller_id,
    oi.price,
    oi.freight_value
FROM orders AS o
INNER JOIN order_items AS oi
    ON oi.order_id = o.order_id
ORDER BY o.order_id, oi.order_item_id
LIMIT 20;

SELECT
    o.order_id,
    o.customer_id,
    o.order_status,
    oi.order_item_id,
    oi.product_id,
    oi.seller_id,
    oi.price,
    oi.freight_value,
    p.product_category_name
FROM orders AS o
INNER JOIN order_items AS oi
    ON oi.order_id = o.order_id
LEFT JOIN products AS p
    ON p.product_id = oi.product_id
ORDER BY o.order_id, oi.order_item_id
LIMIT 20;

SELECT
    o.order_id,
    o.customer_id,
    o.order_status,
    oi.order_item_id,
    oi.product_id,
    oi.seller_id,
    oi.price,
    oi.freight_value,
    p.product_category_name,
    s.seller_city,
    s.seller_state
FROM orders AS o
INNER JOIN order_items AS oi
    ON oi.order_id = o.order_id
LEFT JOIN products AS p
    ON p.product_id = oi.product_id
LEFT JOIN sellers AS s
    ON s.seller_id = oi.seller_id
ORDER BY o.order_id, oi.order_item_id
LIMIT 20;

--Cod 94 Adicionando uma nova coluna como resultado de uma operação
SELECT
    oi.product_id,
    p.product_category_name AS category
FROM order_items AS oi
LEFT JOIN products AS p
    ON p.product_id = oi.product_id
LIMIT 10;

--Cod 95 Selecionando colunas após um filtragem
SELECT
    AVG(oi.price) AS avg_price
FROM order_items AS oi
WHERE oi.order_id IN (
    SELECT o.order_id
    FROM orders AS o
    WHERE o.order_status = 'delivered'
);
---
SELECT
    AVG(oi.price) AS avg_price
FROM orders AS o
INNER JOIN order_items AS oi
    ON oi.order_id = o.order_id
WHERE o.order_status = 'delivered';

--Cod 96 Anexando a tabela resultante de uma operação
SELECT
    cs.customer_state,
    cs.customers,
    ss.sellers
FROM (
    SELECT
        c.customer_state,
        COUNT(*) AS customers
    FROM customer AS c
    GROUP BY
        c.customer_state
) AS cs
LEFT JOIN (
    SELECT
        s.seller_state,
        COUNT(*) AS sellers
    FROM sellers AS s
    GROUP BY
        s.seller_state
) AS ss
    ON ss.seller_state = cs.customer_state
ORDER BY
    cs.customers DESC;


--Cod 97 Qual o número de pedido com o tipo de pagamento igual a “boleto”?
--# Reposta: 19.784 pedidos do tipo boleto

SELECT
    COUNT(DISTINCT o.order_id) AS qtde_pedidos_boleto
FROM orders AS o
WHERE o.order_id IN (
    SELECT op.order_id
    FROM order_payments AS op
    WHERE op.payment_type = 'boleto'
);

--Cod 98 Cria uma tabela que mostre a média de avaliações por dia, a média de preço por dia, a soma dos preços por dia, o preço mínimo por dia, o número de pedidos por dia e o número de clientes únicos que compraram no dia.
DROP TABLE IF EXISTS daily_kpis;

--CREATE TABLE daily_kpis AS

SELECT
    dt.date                       AS date_,
    r.avg_review                  AS avg_review,
    i.avg_price                   AS avg_price,
    i.sum_price                   AS sum_price,
    i.min_price                   AS min_price,
    o.orders_per_day              AS pedidos_por_dia,
    o.unique_customers            AS clientes_unicos
FROM (
    SELECT DATE(o.order_purchase_timestamp) AS date
    FROM orders AS o
    GROUP BY DATE(o.order_purchase_timestamp)
) AS dt
LEFT JOIN (
    SELECT
        DATE(r.review_creation_date) AS date,
        AVG(r.review_score)          AS avg_review
    FROM order_reviews AS r
    GROUP BY DATE(r.review_creation_date)
) AS r
    ON r.date = dt.date
LEFT JOIN (
    SELECT
        DATE(o.order_purchase_timestamp) AS date,
        AVG(oi.price)                    AS avg_price,
        SUM(oi.price)                    AS sum_price,
        MIN(oi.price)                    AS min_price
    FROM order_items AS oi
    INNER JOIN orders AS o
        ON o.order_id = oi.order_id
    GROUP BY DATE(o.order_purchase_timestamp)
) AS i
    ON i.date = dt.date
LEFT JOIN (
    SELECT
        DATE(o.order_purchase_timestamp) AS date,
        COUNT(DISTINCT o.order_id)       AS orders_per_day,
        COUNT(DISTINCT o.customer_id)    AS unique_customers
    FROM orders AS o
    GROUP BY DATE(o.order_purchase_timestamp)
) AS o
    ON o.date = dt.date
ORDER BY dt.date;

--Cod 99 Eu gostaria de saber, por categoria, a quantidade de produtos, o tamanho médio do produto, o tamanho médio da categoria alimentos e o tamanho médio geral.
SELECT
    p.product_category_name,
    COUNT(p.product_id)                         AS produtos,
    AVG(p.product_length_cm)                    AS avg_length,
    (
        SELECT AVG(p2.product_length_cm)
        FROM products AS p2
        WHERE p2.product_category_name = 'alimentos'
    )                                           AS avg_length_alimentos,
    (
        SELECT AVG(p3.product_length_cm)
        FROM products AS p3
    )                                           AS avg_length_all
FROM products AS p
GROUP BY p.product_category_name
ORDER BY produtos DESC;


--Cod 100 Qual o nome da categoria de produto com o maior preço de venda? Encontre a categoria do produto somente com Subqueries.
SELECT DISTINCT
    p.product_category_name
FROM products AS p
WHERE p.product_id IN (
    SELECT oi.product_id
    FROM order_items AS oi
    WHERE oi.price = (
        SELECT MAX(oi2.price)
        FROM order_items AS oi2
    )
);

--Cod 102 --Não tem a tabela clientes
INSERT INTO Clientes (ID, Nome, Cidade, Estado)
SELECT
    c.customer_id,
    c.customer_unique_id,
    c.customer_city,
    c.customer_state
FROM customer AS c
LIMIT 10;


--Cod 103 
--ETAPA 01 Crie uma tabela chamada “Entrega” com 5 colunas:
--a. category
--b. price
--c. shipping
--d. first_purchase_date
--e. days_from_first_purchase"
CREATE TABLE IF NOT EXISTS Entrega (
    category TEXT,
    price REAL,
    shipping REAL,
    first_purchase_date TEXT,
    days_from_first_purchase INTEGER
);

-- ETAPA 02 - Crie uma consulta SQL com as seguintes colunas:
--a. Categoria
--b. Preço
--c. Date limite de envio
--d. Primeira compra
--e. Número de dias que o produto foi comprado a partir da primeira compra dentro da mesma categoria."
WITH table_temp AS (
    SELECT
        p.product_category_name                         AS category,
        CAST(oi.price AS REAL)                          AS price,
        DATE(oi.shipping_limit_date)                    AS shipping_limit_date,
        FIRST_VALUE(DATE(oi.shipping_limit_date)) OVER (
            PARTITION BY p.product_category_name
            ORDER BY DATE(oi.shipping_limit_date)
            ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
        )                                               AS first_purchase_date
    FROM order_items AS oi
    INNER JOIN products AS p
        ON p.product_id = oi.product_id
    WHERE p.product_category_name IS NOT NULL
)
SELECT
    category                                    AS Categoria,
    price                                       AS Preco,
    shipping_limit_date                         AS Data_limite_envio,
    first_purchase_date                         AS Primeira_compra,
    CAST(
        JULIANDAY(shipping_limit_date) - JULIANDAY(first_purchase_date)
        AS INTEGER
    )                                           AS Dias_desde_primeira_compra
FROM table_temp;

--ETAPA03 Insira o resultado da consulta SQL do item 2 na tabela criada no item 1.
--Remova todas linhas que tiverem o preço maior que 29.90 e dias desde a primeira compra maior que 90"
INSERT INTO Entrega (category, price, shipping, first_purchase_date, days_from_first_purchase)
WITH table_temp AS (
    SELECT
        p.product_category_name                         AS category,
        CAST(oi.price AS REAL)                          AS price,
        DATE(oi.shipping_limit_date)                    AS shipping_limit_date,
        FIRST_VALUE(DATE(oi.shipping_limit_date)) OVER (
            PARTITION BY p.product_category_name
            ORDER BY DATE(oi.shipping_limit_date)
            ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
        )                                               AS first_purchase_date
    FROM order_items AS oi
    INNER JOIN products AS p
        ON p.product_id = oi.product_id
    WHERE p.product_category_name IS NOT NULL
)
SELECT
    category,
    price,
    shipping_limit_date,
    first_purchase_date,
    CAST(JULIANDAY(shipping_limit_date) - JULIANDAY(first_purchase_date) AS INTEGER) AS days_from_first_purchase
FROM table_temp;

--ETAPA 04 5. Quantas linhas foram removidas?
--Delete a tabela Entrega do banco de dados"
-- 1) Quantas seriam deletadas?
SELECT COUNT(*) AS linhas_a_remover
FROM Entrega
WHERE price > 29.90
  AND days_from_first_purchase > 90;

-- 2) Deletar
DELETE FROM Entrega
WHERE price > 29.90
  AND days_from_first_purchase > 90;

-- 3) Conferência (deve retornar 0 linhas)
SELECT COUNT(*) AS linhas_remanescentes_criterio
FROM Entrega
WHERE price > 29.90
  AND days_from_first_purchase > 90;

-- 4) Remover a tabela
DROP TABLE IF EXISTS Entrega;

--ETAPA 05 "7. Recrie a tabela Entrega mudando o tipo da coluna “price” para INTEGER"
DROP TABLE IF EXISTS Entrega;

CREATE TABLE IF NOT EXISTS Entrega (
    category TEXT,
    price INTEGER,
    shipping TEXT,                 -- guarde datas em ISO 'YYYY-MM-DD'
    first_purchase_date TEXT,      -- ISO 'YYYY-MM-DD'
    days_from_first_purchase INTEGER
);

--ETAPA 06 8. Insira novamente os valores do item 3
--"Inserindo o resultado da consulta SQL na Tabela criada
INSERT INTO Entrega (category, price, shipping, first_purchase_date, days_from_first_purchase)
WITH table_temp AS (
    SELECT
        p.product_category_name                         AS category,
        ROUND(oi.price)                                 AS price,
        DATE(oi.shipping_limit_date)                    AS shipping_limit_date,
        FIRST_VALUE(DATE(oi.shipping_limit_date)) OVER (
            PARTITION BY p.product_category_name
            ORDER BY DATE(oi.shipping_limit_date)
            ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
        )                                               AS first_purchase_date
    FROM order_items AS oi
    INNER JOIN products AS p
        ON p.product_id = oi.product_id
    WHERE p.product_category_name IS NOT NULL
),
final AS (
    SELECT
        category,
        price,
        shipping_limit_date,
        first_purchase_date,
        CAST(JULIANDAY(shipping_limit_date) - JULIANDAY(first_purchase_date) AS INTEGER) AS days_from_first_purchase
    FROM table_temp
)
SELECT
    category,
    price,
    shipping_limit_date,
    first_purchase_date,
    days_from_first_purchase
FROM final
WHERE NOT (price > 29.90 AND days_from_first_purchase > 90);

--ETAPA 07 "9. Remova todas linhas que tiverem o preço menor que 29.90 e dias desde a primeira compra menor que 90"
DELETE FROM Entrega
WHERE price < 30
  AND days_from_first_purchase < 90;

SELECT COUNT(*) AS linhas_a_remover
FROM Entrega
WHERE price < 30
  AND days_from_first_purchase < 90;

DELETE FROM Entrega
WHERE price < 30
  AND days_from_first_purchase < 90;

SELECT COUNT(*) AS linhas_remanescentes_criterio
FROM Entrega
WHERE price < 30
  AND days_from_first_purchase < 90;

--Cod 104 Crie uma tabela chamada “Vendas” para armazenar o resultado da seguinte consulta: Crie uma consulta SQL usando a cláusula WITH para calcular o total de vendas para cada categoria e exiba o resultado
-- 1) Criar a tabela com os tipos desejados
CREATE TABLE IF NOT EXISTS Vendas (
    name  TEXT,
    price REAL
);

-- 2) Popular a tabela com a consulta (WITH)
INSERT INTO Vendas (name, price)
WITH vendas_por_categoria AS (
    SELECT
        p.product_category_name AS name,
        SUM(COALESCE(oi.price, 0.0)) AS total_price
    FROM order_items AS oi
    LEFT JOIN products AS p
        ON p.product_id = oi.product_id
    WHERE p.product_category_name IS NOT NULL
    GROUP BY p.product_category_name
)
SELECT
    name,
    total_price
FROM vendas_por_categoria;

--Cod 105 "Crie uma tabela chamada “Vendas” para armazenar o resultado da seguinte consulta: Crie uma consulta SQL usando a cláusula WITH para calcular o total de vendas para cada categoria e exiba o resultado:
--1. Se o preço for menor que 300, o desconto é de 10.90
--2. Se o preço for maior que 300 e menor que 5000, o desconto é de 11.90
--3. Se o preço for maior que 5000 e menor que 20000, o desconto é de 12.90
--4. Se o preço for maior que 20000 e menor que 60000, o desconto é de 13.90
--5. Se o preço for maior que 6000, o desconto é de 15.90"
CREATE TABLE IF NOT EXISTS Vendas (
    name  TEXT,
    price REAL
);

DELETE FROM Vendas;

WITH vendas_por_categoria AS (
    SELECT
        p.product_category_name AS name,
        SUM(COALESCE(oi.price, 0.0)) AS price
    FROM order_items AS oi
    LEFT JOIN products AS p
        ON p.product_id = oi.product_id
    WHERE p.product_category_name IS NOT NULL
    GROUP BY p.product_category_name
)
INSERT INTO Vendas (name, price)
SELECT name, price
FROM vendas_por_categoria;
ALTER TABLE Vendas ADD COLUMN desconto REAL;

UPDATE Vendas
SET desconto = CASE
    WHEN price < 300 THEN 10.90
    WHEN price >= 300   AND price < 5000  THEN 11.90
    WHEN price >= 5000  AND price < 20000 THEN 12.90
    WHEN price >= 20000 AND price < 60000 THEN 13.90
    WHEN price >= 60000 THEN 15.90
    ELSE NULL
END;

--Cod 106 "Crie uma consulta que exiba o código do produto e a categoria de cada produto com base no seu preço:
--Preço abaixo de 50 → Categoria A
--Preço entre 50 e 100 → Categoria B
--Preço entre 100 e 500 → Categoria C
--Preço entre 500 e 1500 → Categoria D
--Preço acima de 1500 → Categoria E"
SELECT
    oi.product_id,
    CASE
        WHEN oi.price < 50 THEN 'Categoria A'
        WHEN oi.price >= 50  AND oi.price < 100  THEN 'Categoria B'
        WHEN oi.price >= 100 AND oi.price < 500  THEN 'Categoria C'
        WHEN oi.price >= 500 AND oi.price < 1500 THEN 'Categoria D'
        ELSE 'Categoria E'  -- oi.price >= 1500
    END AS categoria
FROM order_items AS oi;
WITH preco_produto AS (
    SELECT
        oi.product_id,
        AVG(oi.price) AS avg_price
    FROM order_items AS oi
    GROUP BY oi.product_id
)
SELECT
    product_id,
    CASE
        WHEN avg_price < 50 THEN 'Categoria A'
        WHEN avg_price >= 50  AND avg_price < 100  THEN 'Categoria B'
        WHEN avg_price >= 100 AND avg_price < 500  THEN 'Categoria C'
        WHEN avg_price >= 500 AND avg_price < 1500 THEN 'Categoria D'
        ELSE 'Categoria E'  -- avg_price >= 1500
    END AS categoria
FROM preco_produto;

--Cod 107 "Calcule a quantidade de produtos para cada uma das categorias criadas no exercícios anterior."
WITH preco_por_produto AS (
    SELECT
        oi.product_id,
        AVG(oi.price) AS avg_price
    FROM order_items AS oi
    GROUP BY oi.product_id
),
produtos_categorizados AS (
    SELECT
        product_id,
        CASE
            WHEN avg_price < 50 THEN 'Categoria A'
            WHEN avg_price >= 50  AND avg_price < 100  THEN 'Categoria B'
            WHEN avg_price >= 100 AND avg_price < 500  THEN 'Categoria C'
            WHEN avg_price >= 500 AND avg_price < 1500 THEN 'Categoria D'
            ELSE 'Categoria E'  -- avg_price >= 1500
        END AS categoria
    FROM preco_por_produto
)
SELECT
    categoria,
    COUNT(*) AS quantidade_produtos
FROM produtos_categorizados
GROUP BY categoria
ORDER BY categoria;


--Cod 108 "Selecione os seguintes categorias de produtos: livros técnicos, pet shop, pc gamer, tablets impressão imagem, fashion esports, perfumaria, telefonia, beleza saude, ferramentas jardim.
--Crie uma primeira coluna mostrando o novo preço da categoria, segundo os valores abaixo:
--Livros técnicos - 10% de desconto
--Pet shop - 20% de desconto
--PC gamer - 50% de aumento
--Tablets - 10% de aumento
--Fashion Esports - 5% de aumento
--Crie uma segunda coluna mostrando se a categoria sofreu ou não alteração de preço"
SELECT
    p.product_category_name                                       AS categoria,
    oi.price                                                      AS preco_original,
    CASE
        WHEN p.product_category_name = 'livros_tecnicos'            THEN oi.price * 0.90   -- -10%
        WHEN p.product_category_name = 'pet_shop'                   THEN oi.price * 0.80   -- -20%
        WHEN p.product_category_name = 'pc_gamer'                   THEN oi.price * 1.50   -- +50%
        WHEN p.product_category_name = 'tablets_impressao_imagem'   THEN oi.price * 1.10   -- +10%
        WHEN p.product_category_name = 'fashion_esporte_lazer'      THEN oi.price * 1.05   -- +5%
        ELSE oi.price
    END                                                           AS novo_preco,
    CASE
        WHEN p.product_category_name IN (
            'livros_tecnicos',
            'pet_shop',
            'pc_gamer',
            'tablets_impressao_imagem',
            'fashion_esporte_lazer'
        )
        THEN 'alterado'
        ELSE 'normal'
    END                                                           AS status
FROM order_items AS oi
INNER JOIN products AS p
    ON p.product_id = oi.product_id
WHERE p.product_category_name IN (
    'livros_tecnicos',
    'pet_shop',
    'pc_gamer',
    'tablets_impressao_imagem',
    'fashion_esporte_lazer',
    'perfumaria',
    'telefonia',
    'beleza_saude',
    'ferramentas_jardim'
);


--Cod 109 "Qual o valor da média ponderada das avaliações dos produtos que foram comprados a partir do dia 1 de Janeiro de 2018.
--Nota 5 → Peso 0.2
--Nota 4 → Peso 0.1
--Nota 3 → Peso 0.3
--Nota 2 → Peso 0.3
--Nota 1 → Peso 0.1
--Nota 0 → Peso 0.0"
WITH reviews_filtradas AS (
    SELECT
        or2.review_score AS score,
        CASE
            WHEN or2.review_score = 5 THEN 0.20
            WHEN or2.review_score = 4 THEN 0.10
            WHEN or2.review_score = 3 THEN 0.30
            WHEN or2.review_score = 2 THEN 0.30
            WHEN or2.review_score = 1 THEN 0.10
            WHEN or2.review_score = 0 THEN 0.00
            ELSE 0.00
        END AS peso
    FROM order_reviews AS or2
    INNER JOIN orders AS o
        ON o.order_id = or2.order_id
    WHERE DATE(o.order_purchase_timestamp) >= '2018-01-01'
      AND or2.review_score BETWEEN 0 AND 5
)
SELECT
    SUM(score * peso) / NULLIF(SUM(peso), 0) AS media_ponderada
FROM reviews_filtradas;

--Cod 110 Conte quantos parcelas e quantos produtos cada pedido possui.
WITH payments AS (
    SELECT
        op.order_id,
        SUM(op.payment_installments) AS parcelas
    FROM order_payments AS op
    GROUP BY op.order_id
),
products AS (
    SELECT
        oi.order_id,
        COUNT(oi.product_id) AS produtos  -- ou COUNT(DISTINCT oi.product_id)
    FROM order_items AS oi
    GROUP BY oi.order_id
)
SELECT
    o.order_id,
    COALESCE(pa.parcelas, 0) AS parcelas,
    COALESCE(pr.produtos, 0) AS produtos
FROM orders AS o
LEFT JOIN payments AS pa
    ON pa.order_id = o.order_id
LEFT JOIN products AS pr
    ON pr.order_id = o.order_id
ORDER BY o.order_id;

--Cod 111 Conte quantos parcelas e quantos produtos cada pedido possui.
WITH payments AS (
    SELECT
        op.order_id,
        SUM(op.payment_installments) AS parcelas
    FROM order_payments AS op
    GROUP BY op.order_id
),
products AS (
    SELECT
        oi.order_id,
        COUNT(oi.product_id) AS produtos  -- ou COUNT(DISTINCT oi.product_id)
    FROM order_items AS oi
    GROUP BY oi.order_id
)
SELECT
    pa.order_id,
    pa.parcelas,
    pr.produtos
FROM payments AS pa
INNER JOIN products AS pr
    ON pr.order_id = pa.order_id
ORDER BY pa.order_id;

--Cod 112 Calcule o número de dias que se passaram desde a primeira compra de cada categoria, para cada uma das compras posteriores. Por exemplo, se um produto foi comprado no dia seguinte após a primeira compra da categoria, esse produto tem 1 dia de tempo pós início.
WITH base AS (
    SELECT
        p.product_category_name,
        oi.price,
        DATETIME(oi.shipping_limit_date) AS shipping_dt,
        MIN(DATETIME(oi.shipping_limit_date)) OVER (
            PARTITION BY p.product_category_name
        ) AS first_dt
    FROM order_items AS oi
    INNER JOIN products AS p
        ON p.product_id = oi.product_id
    WHERE p.product_category_name IS NOT NULL
)
SELECT
    product_category_name,
    price,
    STRFTIME('%Y-%m-%d', shipping_dt) AS shipping_limit_date,
    STRFTIME('%Y-%m-%d', first_dt)     AS first_purchase,
    CAST(JULIANDAY(shipping_dt) - JULIANDAY(first_dt) AS INTEGER) AS days_from_first_purchase
FROM base
ORDER BY product_category_name, shipping_dt;

--Cod 113 Crie uma consulta SQL usando a cláusula WITH para calcular o total de vendas para cada categoria e exiba o resultado
WITH vendas_por_categoria AS (
    SELECT
        p.product_category_name AS name,
        SUM(COALESCE(oi.price, 0.0)) AS total_vendas
    FROM order_items AS oi
    INNER JOIN products AS p
        ON p.product_id = oi.product_id
    WHERE p.product_category_name IS NOT NULL
    GROUP BY p.product_category_name
)
SELECT
    name,
    total_vendas
FROM vendas_por_categoria
ORDER BY total_vendas DESC;

--Cod 114 Crie uma consulta usando a cláusula WITH para calcular a receita total por mês e exiba o mês com a maior receita.
WITH receita_por_mes AS (
    SELECT
        STRFTIME('%Y-%m', o.order_purchase_timestamp) AS mes_ano,
        SUM(COALESCE(oi.price, 0.0)) AS receita
    FROM orders AS o
    INNER JOIN order_items AS oi
        ON oi.order_id = o.order_id
    GROUP BY STRFTIME('%Y-%m', o.order_purchase_timestamp)
),
ranked AS (
    SELECT
        mes_ano,
        receita,
        DENSE_RANK() OVER (ORDER BY receita DESC) AS rk
    FROM receita_por_mes
)
SELECT
    mes_ano,
    receita
FROM ranked
WHERE rk = 1;

-- Cod 115 Crie uma consulta usando duas cláusulas WITH para calcular o total de vendas por estado e, em seguida, por cidade, e exiba os resultados.
WITH pedidos_por_estado AS (
    SELECT
        c.customer_state AS estado,
        COUNT(oi.product_id) AS total_vendas_estado
    FROM orders AS o
    LEFT JOIN order_items AS oi
        ON oi.order_id = o.order_id
    LEFT JOIN products AS p
        ON p.product_id = oi.product_id
    LEFT JOIN customer AS c
        ON c.customer_id = o.customer_id
    GROUP BY c.customer_state
),
pedidos_por_cidade AS (
    SELECT
        c.customer_state AS estado,
        c.customer_city  AS cidade,
        COUNT(oi.product_id) AS total_vendas_cidade
    FROM orders AS o
    LEFT JOIN order_items AS oi
        ON oi.order_id = o.order_id
    LEFT JOIN products AS p
        ON p.product_id = oi.product_id
    LEFT JOIN customer AS c
        ON c.customer_id = o.customer_id
    GROUP BY c.customer_state, c.customer_city
)
SELECT
    e.estado,
    c.cidade,
    e.total_vendas_estado,
    c.total_vendas_cidade
FROM pedidos_por_estado AS e
INNER JOIN pedidos_por_cidade AS c
    ON c.estado = e.estado
ORDER BY e.total_vendas_estado DESC, c.total_vendas_cidade DESC;


--Cod 116 Calcular o preço médio por categoria e por tipo de pagamento
WITH pagamento_dominante AS (
    SELECT
        order_id,
        payment_type
    FROM (
        SELECT
            op.order_id,
            op.payment_type,
            ROW_NUMBER() OVER (
                PARTITION BY op.order_id
                ORDER BY COALESCE(op.payment_value, 0) DESC,
                         COALESCE(op.payment_installments, 0) DESC,
                         op.payment_type
            ) AS rn
        FROM order_payments AS op
    )
    WHERE rn = 1
)
SELECT
    p.product_category_name,
    pd.payment_type,
    ROUND(AVG(COALESCE(oi.price, 0.0)), 2) AS avg_price
FROM order_items AS oi
INNER JOIN products AS p
    ON p.product_id = oi.product_id
INNER JOIN pagamento_dominante AS pd
    ON pd.order_id = oi.order_id
WHERE p.product_category_name IS NOT NULL
GROUP BY
    p.product_category_name,
    pd.payment_type
ORDER BY
    p.product_category_name,
    pd.payment_type;

--Cod 116 Agregando com RANK()
SELECT
    p.product_category_name,
    oi.price,
    RANK() OVER (
        PARTITION BY p.product_category_name
        ORDER BY oi.price DESC
    ) AS price_rank
FROM order_items AS oi
INNER JOIN products AS p
    ON p.product_id = oi.product_id
WHERE p.product_category_name IS NOT NULL;

--Cod 117 Se a coluna ranqueada possuir valor iguais, ambos valores recebem o mesmo número do ranking e o próximo valor recebe o valor seguinte do ranking.
SELECT
    p.product_category_name,
    oi.price,
    DENSE_RANK() OVER (
        PARTITION BY p.product_category_name
        ORDER BY oi.price DESC
    ) AS price_rank
FROM order_items AS oi
INNER JOIN products AS p
    ON p.product_id = oi.product_id
WHERE p.product_category_name IS NOT NULL;

--Cod 118 Essa função mostra o valor percentual do ranking para cada uma das linhas.
SELECT
    p.product_category_name,
    oi.price,
    PERCENT_RANK() OVER (
        PARTITION BY p.product_category_name
        ORDER BY oi.price DESC
    ) AS price_rank
FROM order_items AS oi
INNER JOIN products AS p
    ON p.product_id = oi.product_id
WHERE p.product_category_name IS NOT NULL;

--Cod 119 Divide os valores da coluna em buckets.
WITH ranked AS (
    SELECT
        p.product_category_name,
        oi.product_id,
        oi.price,
        NTILE(4) OVER (
            PARTITION BY p.product_category_name
            ORDER BY oi.price DESC
        ) AS quartil
    FROM order_items AS oi
    INNER JOIN products AS p
        ON p.product_id = oi.product_id
    WHERE p.product_category_name IS NOT NULL
      AND oi.price IS NOT NULL
)
SELECT
    product_category_name,
    product_id,
    price,
    quartil
FROM ranked
ORDER BY product_category_name, quartil, price DESC;

--Cod 120 Causa um deslocamento adiantado, avançando os valores da coluna.
SELECT
    p.product_category_name,
    oi.price,
    DATETIME(oi.shipping_limit_date) AS shipping_dt,
    LAG(DATETIME(oi.shipping_limit_date)) OVER (
        PARTITION BY p.product_category_name
        ORDER BY DATETIME(oi.shipping_limit_date) ASC
    ) AS prev_shipping_dt
FROM order_items AS oi
INNER JOIN products AS p
    ON p.product_id = oi.product_id
WHERE p.product_category_name IS NOT NULL;

--Cod 121 Causa um deslocamento atrasando, recuando os valores da coluna.
SELECT
    p.product_category_name,
    oi.price,
    DATETIME(oi.shipping_limit_date) AS shipping_dt,
    LAG(DATETIME(oi.shipping_limit_date)) OVER (
        PARTITION BY p.product_category_name
        ORDER BY DATETIME(oi.shipping_limit_date) ASC
    ) AS prev_shipping_dt
FROM order_items AS oi
INNER JOIN products AS p
    ON p.product_id = oi.product_id
WHERE p.product_category_name IS NOT NULL;

--Cod 122 Retorna o menor valor dentro da segmentação da janela
SELECT
    p.product_category_name,
    oi.price,
    DATETIME(oi.shipping_limit_date) AS shipping_dt,
    MIN(DATETIME(oi.shipping_limit_date)) OVER (
        PARTITION BY p.product_category_name
    ) AS first_purchase -- menor data na partição
FROM order_items AS oi
INNER JOIN products AS p
    ON p.product_id = oi.product_id
WHERE p.product_category_name IS NOT NULL;

--Cod 123 Retorna o maior valor dentro da segmentação da janela
SELECT
    p.product_category_name,
    oi.price,
    DATETIME(oi.shipping_limit_date) AS shipping_dt,
    MAX(DATETIME(oi.shipping_limit_date)) OVER (
        PARTITION BY p.product_category_name
    ) AS max_shipping_dt
FROM order_items AS oi
INNER JOIN products AS p
    ON p.product_id = oi.product_id
WHERE p.product_category_name IS NOT NULL;

--Cod 124 Cria uma consulta que liste a categoria, o id do produto, o preço e classificação de cada produto dentro da sua categoria, com base no preço no seu preço médio, a partir do dia 01 de Junho de 2018.
WITH precos_por_produto AS (
    SELECT
        p.product_category_name AS categoria,
        oi.product_id,
        AVG(oi.price) AS preco_medio
    FROM order_items AS oi
    INNER JOIN orders AS o
        ON o.order_id = oi.order_id
    INNER JOIN products AS p
        ON p.product_id = oi.product_id
    WHERE
        o.order_purchase_timestamp >= '2018-06-01 00:00:00'
        AND p.product_category_name IS NOT NULL
        AND oi.price IS NOT NULL
    GROUP BY
        p.product_category_name,
        oi.product_id
)
SELECT
    categoria,
    product_id,
    preco_medio AS preco,
    DENSE_RANK() OVER (
        PARTITION BY categoria
        ORDER BY preco_medio DESC, product_id
    ) AS classificacao
FROM precos_por_produto
ORDER BY
    categoria,
    classificacao,
    preco DESC,
    product_id;

--Cod 125 Crie uma consulta que exiba a data de compra, o valor de cada venda e o total acumulado de vendas até aquela data.
WITH vendas_por_pedido AS (
    SELECT
        o.order_id,
        o.order_purchase_timestamp AS purchase_ts,
        SUM(oi.price) AS valor_venda
        -- Se quiser incluir frete no valor da venda:
        -- SUM(oi.price + COALESCE(oi.freight_value, 0)) AS valor_venda
    FROM orders AS o
    INNER JOIN order_items AS oi
        ON oi.order_id = o.order_id
    GROUP BY
        o.order_id,
        o.order_purchase_timestamp
)
SELECT
    purchase_ts AS data_compra,
    valor_venda,
    SUM(valor_venda) OVER (
        ORDER BY purchase_ts, order_id
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS total_acumulado
FROM vendas_por_pedido
ORDER BY data_compra, order_id;

--Cod 126 Crie uma consulta que exiba a data de compra, o valor de cada venda e a média móvel dos últimos três valores de venda incluindo o valor atual
WITH vendas_por_pedido AS (
    SELECT
        o.order_id,
        o.order_purchase_timestamp AS purchase_ts,
        SUM(oi.price) AS valor_venda
        -- Para incluir frete no valor da venda, use:
        -- SUM(oi.price + COALESCE(oi.freight_value, 0)) AS valor_venda
    FROM orders AS o
    INNER JOIN order_items AS oi
        ON oi.order_id = o.order_id
    GROUP BY
        o.order_id,
        o.order_purchase_timestamp
)
SELECT
    purchase_ts AS data_compra,
    valor_venda,
    AVG(valor_venda) OVER (
        ORDER BY purchase_ts, order_id
        ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
    ) AS media_movel_3
FROM vendas_por_pedido
ORDER BY data_compra, order_id;

--Cod 127 Crie uma consulta que lista a data da compra, o número de produtos vendidos e o crescimento das vendas com relação ao dia anterior.
WITH vendas_por_dia AS (
    SELECT
        DATE(o.order_purchase_timestamp) AS data_venda,
        COUNT(p.product_id) AS vendas
    FROM orders AS o
    INNER JOIN order_items AS oi
        ON oi.order_id = o.order_id
    INNER JOIN products AS p
        ON p.product_id = oi.product_id
    GROUP BY DATE(o.order_purchase_timestamp)
)
SELECT
    data_venda,
    vendas,
    vendas - LAG(vendas) OVER (
        ORDER BY data_venda
    ) AS growth
FROM vendas_por_dia
ORDER BY data_venda;

--Cod 128 Crie uma consulta que exiba o estado do cliente, a categoria, a quantidade de produtos vendidos e o percentual de vendas em relação ao total vendido no estado.
WITH vendas_estado_categoria AS (
    SELECT
        c.customer_state AS state,
        p.product_category_name AS categoria,
        COUNT(oi.product_id) AS produtos
    FROM orders AS o
    INNER JOIN order_items AS oi
        ON oi.order_id = o.order_id
    INNER JOIN products AS p
        ON p.product_id = oi.product_id
    INNER JOIN customer AS c
        ON c.customer_id = o.customer_id
    WHERE p.product_category_name IN ('beleza_saude', 'brinquedos')
    GROUP BY
        c.customer_state,
        p.product_category_name
)
SELECT
    state,
    categoria,
    produtos,
    SUM(produtos) OVER (PARTITION BY state) AS total_estado,
    produtos * 1.0
        / NULLIF(SUM(produtos) OVER (PARTITION BY state), 0) AS percentual_vendas
    -- Opcional: em %
    -- ROUND(100.0 * produtos / NULLIF(SUM(produtos) OVER (PARTITION BY state), 0), 2) AS percentual_vendas_pct
FROM vendas_estado_categoria
ORDER BY state, produtos DESC, categoria;

--Cod 129 Cria uma consulta que liste a categoria, o preço do produto e classificação de cada produto dentro da sua categoria do mais caro ao mais barato com base no preço no seu preço médio, a partir do dia 01 de Junho de 2018.
WITH precos_por_produto AS (
    SELECT
        p.product_category_name AS categoria,
        oi.product_id,
        AVG(oi.price) AS preco_medio
    FROM orders AS o
    INNER JOIN order_items AS oi
        ON oi.order_id = o.order_id
    INNER JOIN products AS p
        ON p.product_id = oi.product_id
    WHERE
        o.order_purchase_timestamp >= '2018-06-01 00:00:00'
        AND p.product_category_name IS NOT NULL
        AND oi.price IS NOT NULL
    GROUP BY
        p.product_category_name,
        oi.product_id
)
SELECT
    categoria,
    product_id,
    preco_medio AS preco,
    DENSE_RANK() OVER (
        PARTITION BY categoria
        ORDER BY preco_medio DESC, product_id
    ) AS classificacao
FROM precos_por_produto
ORDER BY
    categoria,
    classificacao,
    preco DESC,
    product_id;

--Cod 130 "Crie uma consulta que exiba a data de compra, o valor de cada venda e o total acumulado de vendas até aquela data."
WITH vendas_por_pedido AS (
    SELECT
        o.order_id,
        o.order_purchase_timestamp AS purchase_ts,
        SUM(oi.price) AS valor_venda
        -- Se quiser incluir frete: SUM(oi.price + COALESCE(oi.freight_value, 0)) AS valor_venda
    FROM orders AS o
    INNER JOIN order_items AS oi
        ON oi.order_id = o.order_id
    GROUP BY
        o.order_id,
        o.order_purchase_timestamp
)
SELECT
    purchase_ts AS data_compra,
    valor_venda,
    SUM(valor_venda) OVER (
        ORDER BY purchase_ts, order_id
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS total_acumulado
FROM vendas_por_pedido
ORDER BY data_compra, order_id;

--Cod 131 "Crie uma consulta que exiba a data de compra, o valor de cada venda e a média móvel dos últimos três valores de venda incluindo o valor atual"
WITH vendas_por_pedido AS (
    SELECT
        o.order_id,
        o.order_purchase_timestamp AS purchase_ts,
        SUM(oi.price) AS valor_venda
        -- Para incluir frete no valor: SUM(oi.price + COALESCE(oi.freight_value, 0)) AS valor_venda
    FROM orders AS o
    INNER JOIN order_items AS oi
        ON oi.order_id = o.order_id
    GROUP BY
        o.order_id,
        o.order_purchase_timestamp
)
SELECT
    purchase_ts AS data_compra,
    valor_venda,
    AVG(valor_venda) OVER (
        ORDER BY purchase_ts, order_id
        ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
    ) AS media_movel_3
FROM vendas_por_pedido
ORDER BY data_compra, order_id;

--Cod 132 "Crie uma consulta que lista a data da compra, o número de produtos vendidos e o crescimento das vendas com relação ao dia anterior."
WITH vendas_por_dia AS (
    SELECT
        DATE(o.order_purchase_timestamp) AS data_venda,
        COUNT(p.product_id) AS vendas
    FROM orders AS o
    INNER JOIN order_items AS oi
        ON oi.order_id = o.order_id
    INNER JOIN products AS p
        ON p.product_id = oi.product_id
    GROUP BY DATE(o.order_purchase_timestamp)
)
SELECT
    data_venda,
    vendas,
    vendas - LAG(vendas) OVER (ORDER BY data_venda) AS growth
FROM vendas_por_dia
ORDER BY data_venda;

--Cod 133 "Crie uma consulta que exiba o estado do cliente, a categoria, a quantidade de produtos vendidos e o percentual de vendas em relação ao total vendido no estado."
WITH vendas_estado_categoria AS (
    SELECT
        c.customer_state AS state,
        p.product_category_name AS categoria,
        COUNT(oi.product_id) AS produtos
    FROM orders AS o
    INNER JOIN order_items AS oi
        ON oi.order_id = o.order_id
    INNER JOIN products AS p
        ON p.product_id = oi.product_id
    INNER JOIN customer AS c
        ON c.customer_id = o.customer_id
    WHERE p.product_category_name IN ('beleza_saude', 'brinquedos')
      AND p.product_category_name IS NOT NULL
    GROUP BY
        c.customer_state,
        p.product_category_name
)
SELECT
    state,
    categoria,
    produtos,
    SUM(produtos) OVER (PARTITION BY state) AS total_estado,
    produtos * 1.0 / NULLIF(SUM(produtos) OVER (PARTITION BY state), 0) AS percentual_vendas
    -- Opcional em percentual:
    -- ROUND(100.0 * produtos / NULLIF(SUM(produtos) OVER (PARTITION BY state), 0), 2) AS percentual_vendas_pct
FROM vendas_estado_categoria
ORDER BY state, produtos DESC, categoria;

--Cod 134 (Certificação) Qual o nome da categoria com o maior número de pedidos realizados no banco de dados?
SELECT
  p.product_category_name
FROM
  order_items AS oi
JOIN
  products AS p ON oi.product_id = p.product_id
GROUP BY
  p.product_category_name
ORDER BY
  COUNT(oi.order_item_id) DESC
LIMIT 1;

--Categoria com o maior número de pedidos únicos
SELECT
  p.product_category_name
FROM
  orders AS o
JOIN
  order_items AS oi ON o.order_id = oi.order_id
JOIN
  products AS p ON oi.product_id = p.product_id
WHERE
  p.product_category_name IS NOT NULL -- Garante que não contaremos produtos sem categoria
GROUP BY
  p.product_category_name
ORDER BY
  COUNT(DISTINCT o.order_id) DESC
LIMIT 1;


--Cod 135 Número total de vezes que produtos de uma determinada categoria aparecem nos itens de pedido.
SELECT
  p.product_category_name,
  COUNT(*) AS total_itens_vendidos --COUNT(*) conta o nº total de linhas para cada grupo
FROM
  order_items AS oi
JOIN
  products AS p ON oi.product_id = p.product_id --uni a tabela order_itens com products usando a coluna em comum product_id
WHERE
  p.product_category_name IS NOT NULL -- Boa prática para excluir produtos sem categoria (NULL), é uma cláusula de limpeza
GROUP BY --agrupa todas as linhas que pertencem à mesma categoria
  p.product_category_name
ORDER BY
  total_itens_vendidos DESC; --ordena em ordem decrescente

--Cod 136 Total de itens vendidos por categoria. Se a sua intenção for contar o número de pedidos distintos que contêm pelo menos um produto de uma categoria, a consulta seria ligeiramente diferente, usando COUNT(DISTINCT pi.id_pedido).
SELECT
  p.product_category_name,
  COUNT(DISTINCT oi.order_id) AS total_pedidos_distintos
FROM
  order_items AS oi
JOIN
  products AS p ON oi.product_id = p.product_id
WHERE
  p.product_category_name IS NOT NULL
GROUP BY
  p.product_category_name
ORDER BY
  total_pedidos_distintos DESC;

--Cod 137 Qual a categoria com maior soma dos preços de produtos?
SELECT
  p.product_category_name,
  SUM(oi.price) AS receita_total
FROM
  order_items AS oi
JOIN
  products AS p ON oi.product_id = p.product_id
WHERE
  p.product_category_name IS NOT NULL
GROUP BY
  p.product_category_name
ORDER BY
  receita_total DESC;

--Cod 138 Qual o código do produto mais caro da categoria agro indústria & comercio?
SELECT
  p.product_id,
  oi.price
FROM
  order_items AS oi
JOIN
  products AS p ON oi.product_id = p.product_id
WHERE
  p.product_category_name = 'agro_industria_e_comercio'
ORDER BY
  oi.price DESC
LIMIT 1;

--Cod 139 Qual a ordem correta das 3 categorias com os produtos mais caros?
SELECT
  p.product_category_name,
  MAX(oi.price) AS max_price_in_category
FROM
  order_items AS oi
JOIN
  products AS p ON oi.product_id = p.product_id
WHERE
  p.product_category_name IS NOT NULL -- Garante que não estamos analisando produtos sem categoria
GROUP BY
  p.product_category_name
ORDER BY
  max_price_in_category DESC
LIMIT 3;

--Cod 140 Qual o valor dos produtos mais caros das categorias: bebes, flores e seguros e serviços, respectivamente
SELECT
  p.product_category_name,
  MAX(oi.price) AS max_price
FROM
  order_items AS oi
JOIN
  products AS p ON oi.product_id = p.product_id
WHERE
  p.product_category_name IN ('bebes', 'flores', 'seguros_e_servicos')
GROUP BY
  p.product_category_name;

--Cod 141 Quantos pedidos possuem um único comprador, 3 produtos e o pagamento foi dividido em 10 parcelas?
WITH PedidosCom3Produtos AS (
  -- Passo 1: Encontrar todos os pedidos que têm exatamente 3 itens
  SELECT
    order_id
  FROM
    order_items
  GROUP BY
    order_id
  HAVING
    COUNT(order_item_id) = 3
),
PedidosCom10Parcelas AS (
  -- Passo 2: Encontrar todos os pedidos com pagamento em 10 parcelas
  SELECT DISTINCT
    order_id
  FROM
    order_payments
  WHERE
    payment_installments = 10
)
-- Passo 3: Contar quantos pedidos estão em ambas as listas
SELECT
  COUNT(p3.order_id) AS total_pedidos
FROM
  PedidosCom3Produtos AS p3
JOIN
  PedidosCom10Parcelas AS p10 ON p3.order_id = p10.order_id;


--Segunda forma de escrever o Cod 141
-- Etapa 1: Identificar todos os clientes que fizeram APENAS UM pedido.
WITH clientes_com_um_pedido AS (
  SELECT
    customer_id
  FROM
    orders
  GROUP BY
    customer_id
  HAVING
    COUNT(order_id) = 1
),
-- Etapa 2: Identificar todos os pedidos que contêm EXATAMENTE 3 produtos.
pedidos_com_3_produtos AS (
  SELECT
    order_id
  FROM
    order_items
  GROUP BY
    order_id
  HAVING
    COUNT(product_id) = 3
),
-- Etapa 3: Identificar todos os pedidos pagos em EXATAMENTE 10 parcelas.
pedidos_com_10_parcelas AS (
  SELECT DISTINCT
    order_id
  FROM
    order_payments
  WHERE
    payment_installments = 10
)
-- Etapa Final: Contar quantos pedidos atendem a TODAS as três condições.
SELECT
  COUNT(T1.order_id) AS total_pedidos_filtrados
FROM
  orders AS T1
WHERE
  -- Condição 1: O cliente do pedido deve estar na nossa lista de clientes com um único pedido.
  T1.customer_id IN (SELECT customer_id FROM clientes_com_um_pedido)
  -- Condição 2: O ID do pedido deve estar na nossa lista de pedidos com 3 produtos.
  AND T1.order_id IN (SELECT order_id FROM pedidos_com_3_produtos)
  -- Condição 3: O ID do pedido deve estar na nossa lista de pedidos com 10 parcelas.
  AND T1.order_id IN (SELECT order_id FROM pedidos_com_10_parcelas);

--Cod 142 Quantos pedidos foram parcelados em mais de 10 vezes ?
SELECT
  COUNT(DISTINCT order_id) AS total_pedidos
FROM
  order_payments
WHERE
  payment_installments > 10;

--Cod 143 Quantos clientes avaliaram o pedido com 5 estrelas?
SELECT
  COUNT(review_score) AS total_avaliacoes_5_estrelas
FROM
  order_reviews
WHERE
  review_score = 5;

--Cod 144 Quantos clientes avaliaram o pedido com 4 estrelas?
SELECT
  COUNT(review_score) AS total_avaliacoes_5_estrelas
FROM
  order_reviews
WHERE
  review_score = 4;

--Cod 145 Quantos clientes avaliaram o pedido com 3 estrelas?
SELECT
  COUNT(review_score) AS total_avaliacoes_5_estrelas
FROM
  order_reviews
WHERE
  review_score = 3;
  
--Cod 146 Quantos clientes avaliaram o pedido com 2 estrelas?
SELECT
  COUNT(review_score) AS total_avaliacoes_5_estrelas
FROM
  order_reviews
WHERE
  review_score = 2;
  
--Cod 147 Quantos clientes avaliaram o pedido com 1 estrelas?
SELECT
  COUNT(review_score) AS total_avaliacoes_5_estrelas
FROM
  order_reviews
WHERE
  review_score = 1;

-- Cod 148 No dia 2 de Outubro de 2016, qual era o valor da média móvel dos últimos 7 dias?
WITH faturamento_diario AS (
    -- Esta CTE calcula o faturamento total para cada dia
    SELECT
        DATE(o.order_purchase_timestamp) AS data_pedido,
        SUM(p.payment_value) AS faturamento_do_dia
    FROM
        orders AS o
    JOIN
        order_payments AS p ON o.order_id = p.order_id -- CORRIGIDO: de 'olist_order_payments_dataset' para 'order_payments'
    GROUP BY
        data_pedido
)
-- A consulta principal calcula a média móvel sobre os dados da CTE
SELECT
    data_pedido,
    faturamento_do_dia,
    AVG(faturamento_do_dia) OVER (
        ORDER BY data_pedido
        ROWS BETWEEN 6 PRECEDING AND CURRENT ROW --instrução exata para média móvel de 7 dias - calcula a média do valor desta linha e das 6 linhas anteriores
    ) AS media_movel_7dias
FROM
    faturamento_diario
WHERE
    data_pedido = '2016-10-02'; -- ATUALIZADO: Usando a data que sabemos ter dados
    
--Segunda forma de fazer o Cod 148
    -- Utilizando Expressões de Tabela Comuns (CTEs) para organizar a lógica
WITH vendas_diarias AS (
  -- Passo 1: Agrupar o valor total de pagamentos por dia de compra
  SELECT
    DATE(o.order_purchase_timestamp) AS dia,
    SUM(op.payment_value) AS valor_total_dia
  FROM
    orders o
    JOIN order_payments op ON o.order_id = op.order_id
  GROUP BY
    dia
),
media_movel_diaria AS (
  -- Passo 2: Calcular a média móvel de 7 dias sobre os valores diários
  SELECT
    dia,
    AVG(valor_total_dia) OVER (
      ORDER BY
        dia ROWS BETWEEN 6 PRECEDING
        AND CURRENT ROW
    ) AS media_movel_7d
  FROM
    vendas_diarias
)
-- Passo 3: Selecionar o valor da média móvel para a data específica
SELECT
  media_movel_7d
FROM
  media_movel_diaria
WHERE
  dia = '2016-10-02';

--Outra ideia para o cod 148
SELECT
  SUM(op.payment_value) / 7.0 AS moving_average_7_days
FROM
  orders AS o
JOIN
  order_payments AS op ON o.order_id = op.order_id
WHERE
  o.order_purchase_timestamp BETWEEN datetime('2016-10-02 23:59:59', '-7 days') AND '2016-10-02 23:59:59';

--Cod 149 No dia 5 de Outubro de 2016 as 08:04:21, qual era o valor da média móvel dos últimos 14 dias?
--A média móvel é uma métrica calculada sobre um período de dias completos. Portanto, o valor em 05/10/2016 às 08:04:21 é o mesmo valor para o dia 05/10/2016 inteiro. 
WITH faturamento_diario AS (
    -- 1. Agrega o faturamento por dia, formando a base do cálculo.
    SELECT
        DATE(o.order_purchase_timestamp) AS data_pedido,
        SUM(p.payment_value) AS faturamento_do_dia
    FROM
        orders AS o
    JOIN
        order_payments AS p ON o.order_id = p.order_id
    GROUP BY
        data_pedido
)
-- 2. Calcula a média móvel sobre os dados diários e filtra pela data exata.
SELECT
    data_pedido,
    faturamento_do_dia,
    -- A mágica acontece aqui:
    AVG(faturamento_do_dia) OVER (
        ORDER BY data_pedido
        ROWS BETWEEN 13 PRECEDING AND CURRENT ROW -- Ajustado para 14 dias (13 anteriores + o dia atual)
    ) AS media_movel_14dias
FROM
    faturamento_diario
WHERE
    data_pedido = '2016-10-05';

--Ideia para o Cod 149
SELECT
  SUM(op.payment_value) / 14.0 AS moving_average_14_days
FROM
  orders AS o
JOIN
  order_payments AS op ON o.order_id = op.order_id
WHERE
  o.order_purchase_timestamp BETWEEN datetime('2016-10-05 08:04:21', '-14 days') AND '2016-10-05 08:04:21';

--tentativa 02
WITH vendas_por_dia AS (
    SELECT
        DATE(o.order_purchase_timestamp) AS data,
        SUM(oi.price) AS valor_dia
        -- Se quiser incluir frete: SUM(oi.price + COALESCE(oi.freight_value, 0)) AS valor_dia
    FROM orders AS o
    INNER JOIN order_items AS oi
        ON oi.order_id = o.order_id
    WHERE o.order_purchase_timestamp <= '2016-10-05 08:04:21'
    GROUP BY DATE(o.order_purchase_timestamp)
),
serie AS (
    SELECT
        data,
        valor_dia,
        AVG(valor_dia) OVER (
            ORDER BY data
            ROWS BETWEEN 13 PRECEDING AND CURRENT ROW
        ) AS media_movel_14d
    FROM vendas_por_dia
)
SELECT
    media_movel_14d
FROM serie
WHERE data = DATE('2016-10-05 08:04:21');

--tentativa 03
WITH receita_por_dia AS (
    SELECT
        DATE(o.order_purchase_timestamp) AS data,
        SUM(oi.price) AS valor_dia
    FROM orders o
    INNER JOIN order_items oi ON oi.order_id = o.order_id
    WHERE o.order_purchase_timestamp < '2016-10-05 00:00:00'
    GROUP BY DATE(o.order_purchase_timestamp)
),
serie AS (
    SELECT
        data,
        valor_dia,
        AVG(valor_dia) OVER (
            ORDER BY data
            ROWS BETWEEN 13 PRECEDING AND CURRENT ROW
        ) AS media_movel_14d
    FROM receita_por_dia
)
SELECT media_movel_14d
FROM serie
ORDER BY data DESC
LIMIT 1;

--entativa 04
WITH receita_por_dia AS (
    SELECT
        DATE(o.order_purchase_timestamp) AS data,
        SUM(oi.price) AS valor_dia
    FROM orders o
    INNER JOIN order_items oi ON oi.order_id = o.order_id
    WHERE o.order_purchase_timestamp <= '2016-10-05 23:59:59'
    GROUP BY DATE(o.order_purchase_timestamp)
),
serie AS (
    SELECT
        data,
        valor_dia,
        AVG(valor_dia) OVER (
            ORDER BY data
            ROWS BETWEEN 13 PRECEDING AND CURRENT ROW
        ) AS media_movel_14d
    FROM receita_por_dia
)
SELECT media_movel_14d
FROM serie
WHERE data = DATE('2016-10-05 00:00:00');

---tentativa 05
-- Supondo taxa fixa (ex.: 1 USD = 3.20 BRL). Ajuste a taxa conforme a regra oficial.
WITH receita_por_dia AS (
    SELECT
        DATE(o.order_purchase_timestamp) AS data,
        SUM(oi.price) AS valor_dia_brl
    FROM orders o
    INNER JOIN order_items oi ON oi.order_id = o.order_id
    WHERE o.order_purchase_timestamp <= '2016-10-05 23:59:59'
    GROUP BY DATE(o.order_purchase_timestamp)
),
serie AS (
    SELECT
        data,
        valor_dia_brl / 3.20 AS valor_dia_usd
    FROM receita_por_dia
)
SELECT
    ROUND(
        AVG(valor_dia_usd) OVER (
            ORDER BY data
            ROWS BETWEEN 13 PRECEDING AND CURRENT ROW
        )
    , 2) AS media_movel_14d_usd
FROM serie
WHERE data = DATE('2016-10-05 00:00:00');


--Cod 150 Qual o código do produto da categoria agro indústria e comércio que está na 5 posição do ranking de produtos mais caros dessa categoria?
-- Etapa 1: Isolar os produtos da categoria e encontrar o preço MÁXIMO de cada um.
WITH produtos_agro_preco_maximo AS (
    SELECT
        p.product_id,
        MAX(oi.price) AS max_price -- Usamos MAX() pois um mesmo produto pode ter preços diferentes em vendas distintas
    FROM
        products AS p
    JOIN
        order_items AS oi ON p.product_id = oi.product_id
    WHERE
        p.product_category_name = 'agro_industria_e_comercio'
    GROUP BY
        p.product_id
),
-- Etapa 2: Criar um ranking desses produtos com base no seu preço máximo.
ranking_de_precos AS (
    SELECT
        product_id,
        max_price,
        -- Aqui criamos o ranking decrescente de preços. Usamos DENSE_RANK para lidar com empates sem pular posições.
        DENSE_RANK() OVER (ORDER BY max_price DESC) AS ranking
    FROM
        produtos_agro_preco_maximo
)
-- Etapa Final: Selecionar o produto que está na 5ª posição do ranking.
SELECT
    product_id
FROM
    ranking_de_precos
WHERE
    ranking = 5;



--Cod 151 Qual o código do produto da categoria artes que está na posição 1 do ranking de produtos mais caros dessa categoria?
SELECT
  T2.product_id
FROM
  order_items AS T1
JOIN
  products AS T2 ON T1.product_id = T2.product_id
WHERE
  T2.product_category_name = 'artes'
ORDER BY
  T1.price DESC
LIMIT 1;

--Cod 152 Qual o valor da soma de todos que estão acima da posição 5 do ranking de produtos mais caros da categoria brinquedos.
-- Etapa 1: Identificar os 5 produtos mais caros da categoria 'brinquedos'
WITH top_5_brinquedos AS (
  SELECT
    T1.product_id
  FROM
    order_items AS T1
  JOIN
    products AS T2 ON T1.product_id = T2.product_id
  WHERE
    T2.product_category_name = 'brinquedos'
  ORDER BY
    T1.price DESC
  LIMIT 5
)
-- Etapa 2: Buscar os IDs dos clientes que compraram esses produtos
SELECT DISTINCT
  T2.customer_id
FROM
  order_items AS T1
JOIN
  orders AS T2 ON T1.order_id = T2.order_id
WHERE
  T1.product_id IN (SELECT product_id FROM top_5_brinquedos);

--o valor da soma de todos que estão acima da posição 5 do ranking de produtos mais caros da categoria brinquedos.
-- Etapa 1: Criar uma tabela temporária (CTE) com os 5 maiores preços da categoria 'brinquedos'
WITH top_5_precos_brinquedos AS (
  SELECT
    T1.price
  FROM
    order_items AS T1
  JOIN
    products AS T2 ON T1.product_id = T2.product_id
  WHERE
    T2.product_category_name = 'brinquedos'
  ORDER BY
    T1.price DESC
  LIMIT 5
)
-- Etapa 2: Somar os valores da tabela temporária criada acima
SELECT
  SUM(price) AS soma_top_5_brinquedos
FROM
  top_5_precos_brinquedos;

-- Utiliza uma CTE (Common Table Expression) para criar o ranking e depois filtrar
WITH ProdutosBrinquedos AS (
  /* Passo 1: Selecionar o preço de cada produto distinto da categoria 'brinquedos' */
  SELECT DISTINCT
    p.product_id,
    oi.price
  FROM
    products AS p
  JOIN
    order_items AS oi ON p.product_id = oi.product_id
  WHERE
    p.product_category_name = 'brinquedos'
),
RankingPrecos AS (
  /* Passo 2: Rankear os produtos encontrados pelo preço, do mais caro para o mais barato */
  SELECT
    price,
    RANK() OVER (ORDER BY price DESC) as ranking_preco
  FROM
    ProdutosBrinquedos
)
/* Passo 3: Somar o preço dos produtos que estão nas 4 primeiras posições */
SELECT
  SUM(price) AS soma_dos_top_4_mais_caros
FROM
  RankingPrecos
WHERE
  ranking_preco <= 4;

--Ideia complementar - Quais os preços dos produtos mais caros da categoria brinquedo em ordem decrescente
SELECT DISTINCT
  p.product_id,
  oi.price
FROM
  products AS p
JOIN
  order_items AS oi ON p.product_id = oi.product_id
WHERE
  p.product_category_name = 'brinquedos'
ORDER BY
  oi.price DESC;

--Cod 153 Qual a categoria que possui o produto com o maior número de dias entre a primeira compra da categoria e a sua data limite de entrega?
-- Etapa 1: Encontra a data da primeira compra para cada categoria
WITH primeiras_compras_por_categoria AS (
  SELECT
    T2.product_category_name,
    MIN(T3.order_purchase_timestamp) AS data_primeira_compra
  FROM
    order_items AS T1
  JOIN
    products AS T2 ON T1.product_id = T2.product_id
  JOIN
    orders AS T3 ON T1.order_id = T3.order_id
  GROUP BY
    T2.product_category_name
),
diferenca_por_item AS (-- Etapa 2: Calcula a diferença em dias para cada item de pedido individualmente
  SELECT
    T2.product_category_name,
    -- Calcula a diferença em dias entre a data limite de envio e a primeira compra da categoria
    JULIANDAY(T1.shipping_limit_date) - JULIANDAY(T3.data_primeira_compra) AS dias_diferenca
  FROM
    order_items AS T1
  JOIN
    products AS T2 ON T1.product_id = T2.product_id
  JOIN
    primeiras_compras_por_categoria AS T3 ON T2.product_category_name = T3.product_category_name
)
SELECT -- Etapa 3 (Consulta Final): Encontra a categoria com a maior diferença de dias
  product_category_name
FROM
  diferenca_por_item
ORDER BY
  dias_diferenca DESC
LIMIT 1;


