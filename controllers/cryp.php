<?php
$password = password_hash("123456",PASSWORD_BCRYPT);

echo $password;