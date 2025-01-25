## Про скрипт

- [Англ](README.md) [Ру](ru.md) Укр версія

Цей скрипт створен для простого встановлення ArchLinux [JustJabka](https://github.com/JustJabka).

## Укр гайд
1. Підєднаннайтесь до wifi, чи якщо у вас Ethernet (проводний) підключення, пропустіть цей крок
2. Відформатуйте та позначте ваш диск
3. Завантажте preinstall.sh

   ```curl https://raw.githubusercontent.com/JustJabka/archinstall/main/preinstall.sh -o preinstall.sh```

4. Запустіть preinstall.sh

  ```sh preinstall.sh```

5. Увведіть:
    - hostname (назва прилада)
    - root password (пароль учетного записа Адміністратора)
    - username (назва учетного записа користувача)
    - user password (пароль учетного записа користувача)
    - EFI partition (загрузочний розділ)
    - swap partition (розділ для вивантаження сторінок, що не використовуються, з оперативної пам'яті)
    - root partition (основний розділ де буде встановлена система)

6. Чекайте перезавантаження комп'ютера