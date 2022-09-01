# TODO

## Questions
 - Alkalmazottnak nem kötelező céghez tartoznia? (Vezetéknév(kötelező), Keresztnév(kötelező), Hozzá tartozó cégnév, email cím, telefonszám)
 - Alkalmazott - Cég 1:1 kapcsolat, igaz? Elvégre egy alkalmazott egyszerre csak egy cégnél dolgozhat.
 - "Az admin tudja módosítani" - tehát CRUD jogosultsgokat külön felhasználótipusokra kell kezelni, igaz?
   - A.) Van egy nyilvános felület, ahol ezeke a dolgok elérhetők + egy bejelentkezésre kiegészül a felület szerkesztéssel.
   - B.) A felületre be lehet lépni read-only userként, és adminként, de bejelentkezés nélkül nem nyilvános semmi.
   - C.) más?

## Laravel+flutter+mariia in docker;
For flutter
https://hub.docker.com/r/danjellz/http-server/#!

For laravel:
https://hub.docker.com/r/bitnami/laravel/

## Server(josn api, with and without autentiaction)

### Authentication

## Client

### Home 
Admin login button on middle ;
    -> auth screen -> enables action buttons for datatables
Comapnies button;
Employees button;

### Companies (From side menu or home)
Datatable:
| Logo | Name | Link | Email | Number of employees

Actions:
New company, delete company(don't let delete company with employee), select multiple for delete, Edit company

#### Edit/New company
Edit company data, 

#### Employees of company
Datatable of employees (actions: move employee to this company, move employee from this company)

### Employees (From side menu or home)
Datatable:
| First name | Last name | Company(Link to company page) | Email | Phone

Actions: Delete, multi delete, edit new

#### Edit/New Employee
F name(REQ), L name(REQ), choose company(REQ), email, phone

## 2.0
 - Better UX for moving emplonyee between companies
 - multi delete api route
 - seeder in different files
 - company, employee migration down method implementation(foreign keys)
 - validationg email with "email" => "email:rfc,dns" (keep the option of leaving it empty)
 - validationg phone number with regex

## other todos:
 - auth
 - auth in flutter
 - open companies wothut hardcoded true
 - show logo
 - upload logo
 - test the whole thing
 - build
 - test on different computer
 - link to email, phone number

