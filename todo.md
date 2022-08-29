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

### Public

#### List Companies

#### List Employees

#### List company employees(company id)

#### Get employee data(employee id)

#### Get company data(company id)

### Private(authenticated)

### Create company(name(REQ), logo, email, phone)

### Edit company(company id, name(REQ), logo, email, phone)

### Create employee(f-name(REQ), l-name(REQ), company(REQ), email, phone)

### Delete company(company id)
only when employees not present in the company

### Edit employee(employee id, f-name(REQ), l-name(REQ), company(REQ), email, phone)

### Delete employee(employee id)

### Move employee(employee id, from company id, to company id)


## Client

### Home 
Admin login button on middle -> auth screen -> enables action buttons for datatables
Comapnies button
Employees button

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
