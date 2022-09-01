# TODO
 - [ux] Better UX for moving emplonyee between companies (current solution is to set company individually on every employee)
 - [ux] Validate email, phone  on front-end
 - [performance] multi delete api route(currently when we wanna delet multiple items at the same time, we call destroy for each, destroyAll might be more performant)
 - [code quality] running `down` method from `_create_comapnies_table.php` will result in broken foreign key references
 - [code quality] custom docker with nginx/apache as webserver. Current setup [having issues with CORS](https://github.com/fruitcake/laravel-cors/issues/504#issuecomment-1233990808)


