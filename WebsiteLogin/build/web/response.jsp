<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="css/style.css">
    <title>Mensagem</title>
</head>
<body>  
    <div class="container-response">
        <h2><%= request.getAttribute("response") %></h2>
        <a href="index.html"><button class="btn">Voltar</button></a>
    </div>
</body>
</html>
