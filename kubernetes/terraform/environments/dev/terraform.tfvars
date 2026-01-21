namespace_name = "nginx-dev"
nginx_image    = "nginx:stable"
replicas       = 1

red_html_content = <<-EOT
<!DOCTYPE html>
<html>
<head>
  <title>RED NGINX - DEV</title>
  <style>
    body {
      background-color: #ff0000;
      color: white;
      font-family: Arial, sans-serif;
      display: flex;
      justify-content: center;
      align-items: center;
      height: 100vh;
      margin: 0;
    }
    .container {
      text-align: center;
    }
    h1 {
      font-size: 3em;
      margin: 0;
    }
    p {
      font-size: 1.2em;
    }
    .badge {
      background-color: rgba(255, 255, 255, 0.2);
      padding: 5px 15px;
      border-radius: 5px;
      margin-top: 10px;
    }
  </style>
</head>
<body>
  <div class="container">
    <h1>RED NGINX</h1>
    <p class="badge">ENVIRONMENT: DEV</p>
    <p>Load-balanced RED instance</p>
  </div>
</body>
</html>
EOT

blue_html_content = <<-EOT
<!DOCTYPE html>
<html>
<head>
  <title>BLUE NGINX - DEV</title>
  <style>
    body {
      background-color: #0000ff;
      color: white;
      font-family: Arial, sans-serif;
      display: flex;
      justify-content: center;
      align-items: center;
      height: 100vh;
      margin: 0;
    }
    .container {
      text-align: center;
    }
    h1 {
      font-size: 3em;
      margin: 0;
    }
    p {
      font-size: 1.2em;
    }
    .badge {
      background-color: rgba(255, 255, 255, 0.2);
      padding: 5px 15px;
      border-radius: 5px;
      margin-top: 10px;
    }
  </style>
</head>
<body>
  <div class="container">
    <h1>BLUE NGINX</h1>
    <p class="badge">ENVIRONMENT: DEV</p>
    <p>Load-balanced BLUE instance</p>
  </div>
</body>
</html>
EOT
