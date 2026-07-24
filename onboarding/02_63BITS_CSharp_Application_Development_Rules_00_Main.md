# Application Development Rules

This document defines the official application development standards for 63BITS. It establishes structural conventions, naming rules, formatting guidelines, and implementation restrictions to ensure consistency, maintainability, and readability across all projects.

<br>

## Naming Standards

<br>

### Folder Naming Rule

Folder names for server-side C# code must use PascalCase.

<br>

### File Naming Rule

File names for server-side C# code must use PascalCase.

<br>

### Implicit Private Access Modifier Rule

Do not explicitly specify `private` for private members; they are private by default.

```csharp
// Wrong
private string _userFullname;

// Correct
string _userFullname;
```

<br>

### Class and Record Naming Rules

Use PascalCase naming for class, record, or struct names.

```csharp
public class UsersRepository { }

public record UserDTO { }
```

<br>

### Record Explicit Property Accessors Rule

Always declare record properties explicitly using `get; init;`.

```csharp
public record UserDTO
{
    public string UserFirstname { get; init; }
}
```

<br>

### Class Meaningful Naming Rule

Class names must clearly and accurately describe the purpose of the class. Avoid meaningless or abbreviated alphanumeric names.

```csharp
// Wrong
public class U { }
public class U1 { }
public class Usr { }

// Correct
public class User { }
```

<br>

### Class and Record Usage Rule

Use `record` exclusively for DTO objects. NEVER use `class` for DTO objects.

<br>

### Class Public Members Naming Rule

Use PascalCase naming for public properties, fields, constants, and static members.

```csharp
public int? UserID { get; set; }
public string UserFirstName { get; set; }
```

<br>

### Class Private Members Naming Rule

Use underscore-prefixed camelCase naming for private fields, constants, and static members.

```csharp
string _userFullname;
```

<br>

### Public Methods Naming Rule

Use PascalCase naming for public methods.

```csharp
public void CreateUser( ... )
```

<br>

### Private Methods Naming Rule

Use camelCase naming for private methods.

```csharp
string getUserFullname( ... )
```

<br>

### Method Meaningful Naming Rule

Method names must clearly and accurately describe the purpose of the method. Avoid meaningless or abbreviated alphanumeric names.

```csharp
// Wrong
public void CrUsr ( ... )

// Correct
public void CreateUser( ... )
```

<br>

### Method Parameters and Variables Naming Rule

Use camelCase naming for variables and method parameters.

```csharp
public void CreateUser(string userFirstname, string userLastname)
var userFullname = $"{userFirstname} {userLastname}";
```

<br>

### Property/Variable/Parameter Meaningful Naming Rule

Class property names must clearly and accurately describe the purpose of the property. Avoid meaningless or abbreviated alphanumeric names.

Record property names must usually match up with database column names, or otherwise clearly and accurately describe the purpose of the property. Avoid meaningless or abbreviated alphanumeric names.

```csharp
// Wrong
var uPsw;
public string UsrPsw { get; set; }
public void CreateUser(string uFname, string uLname)

// Correct
var userPassword;
public string UserPassword { get; set; }
public void CreateUser(string userFirstname, string userLastname)
```

The only exception is the use of the variable names `i`, `j`, and `k`, which may be used only within `for` loops, and only at the appropriate nesting level:

```csharp
for (var i = 0; i < 10; i++)
{
    for (var j = 0; j < 10; j++)
    {
        for (var k = 0; k < 10; k++)
        {

        }
    }
}
```

- `i` is allowed only for the first level of loop.
- `j` is allowed only for the second level of loop.
- `k` is allowed only for the third level of loop.

<br>

## Method Call and Formatting Rules

Always use named arguments when calling methods that have more than one parameter. Named arguments are optional when calling methods with a single parameter.

Keep the entire call on a single line when passing one or two parameters:

```csharp
var user = UsersGetSingleByID(userID)
```

When passing more than two parameters, format the call across multiple lines as follows:

```csharp
UsersCreate(
    userFirstname: "Joe",
    userLastname: "Doe",
    userEmail: "joe@doe.com",
);
```

Directly accessing properties from a method call is strictly prohibited.

```csharp
// Wrong
var userFirstname = repository.UsersGetSingleByID(userID)).UserFirstname;

// Correct
var user = repository.UsersGetSingleByID(userID);
if (user != null)
{
    userFirstname = user.UserFirstname;
}
```

<br>

## Class File Structure Rule

Every class shall reside in its own source file. A source file must not contain more than one class. This rule applies to all classes, records, structures, and interface types.

Example:

- `public class UsersRepository` must be placed in a file named `UsersRepository.cs`
- `public record UserDTO` must be placed in a file named `UserDTO.cs`

<br>

### Class Member Ordering Rule

Define class members in the following order:

1. Properties, fields, and constants
2. Constructors
3. Public methods
4. Private methods
5. Nested classes

<br>

### #region Wrapping Rules

- Wrap all properties, fields, and constants within a `#region Properties`.
- Wrap all constructors within a `#region Constructors`.
- Wrap all public methods within a `#region Methods`.
- Wrap all private methods within a `#region Private Methods`.

<br>

### Line Spacing Rules

Use these spacing rules:

- Keep private property members without line spacing. Keep public property members without line spacing.
- Separate private and public properties with one empty line.
- Separate all `#region` blocks with one empty line, and separate individual methods with one empty line.
- Do not separate the first method from the `#region` block with one empty line.
- Do not separate the last method's ending from the `#endregion` block with one empty line.

<br>

### Sorting Rules

Use the following sorting rules to determine which method shows up first and which second:

- Sort methods alphabetically.
- Sort methods in scope of `#region`.
  - Public methods are sorted within `#region Methods` alphabetically.
  - Private methods are sorted within `#region Private Methods` alphabetically.
- Sort nested classes alphabetically.
- Sort class properties according to the following rules:
  - Private const properties come first.
    - Place each private const property on a new line.
    - Do not separate private const properties with an empty line in between.
    - Separate the next group from the private const properties with an empty line.
  - Private readonly properties come next.
    - Place each private readonly property on a new line.
    - Do not separate private readonly properties with an empty line in between.
    - Separate the next group from the private readonly properties with an empty line.
  - The primary ID property has top priority and must always come first.

Example:

```csharp
public class Product
{
    #region Properties
    const int _myConst1 = 1;
    const int _myConst2 = 2;

    readonly string _myString1;
    readonly string _myString2;


    public int ProductID { get; set; }
    public int ProductNameKa { get; set; }
    public int ProductNameEn { get; set; }
    #endregion

    #region Constructors
    public Product()
    {

    }
    #endregion

    #region Methods
    public void AlphaMethod()
    {

    }

    public void BetaMethod()
    {

    }
    #endregion


    #region Private Methods
    void alphaPrivateMethod()
    {

    }

    void betaPrivateMethod()
    {

    }
    #endregion

    #region Nested Classes
    public class NestedClass
    {

    }
    #endregion
}
```

<br>

## If Statement Rules

<br>

### Curly Brace Formatting Standard

Always use curly braces `{ }` for `if` statements, regardless of the number of statements inside the block. Place curly braces on separate lines, with the opening brace on a new line after the condition and the closing brace aligned vertically.

```csharp
if (isConditionSatisfied)
{
    ...
}
```

<br>

### Pre-Evaluated Boolean Conditions for If Statements

Always use a pre-calculated boolean variable in `if` conditions. Direct method calls or any type of expression must not be used directly inside an `if` statement.

```csharp
// Wrong
if (basketItemCount - stockAvailableCount < 0)
if (IsProductStockAvailable(basketItemCount))
if (isProductStockAvailable && (isPaid || totalPrice == 0))
if (isProductStockAvailable && isPaid)

// Correct
var isOrderReady = isProductStockAvailable && (isPaid || totalPrice == 0);
if (isOrderReady)
```

<br>

## LINQ Formatting Rules

Format LINQ projection (`Select`) statements as shown below:

- Place the `Select`, lambda expression, and `new` object declaration on a single line.
- Place the opening brace `{` on a new line.
- Place each property assignment on a separate line, indented with a Tab.
- Place the closing brace and parenthesis `})` on a new line, followed by the `.ToList()` call.
- When chaining multiple LINQ methods, format one method call per line.

```csharp
var usersFiltered = Users
    .Where(item => ... )
    .OrderByDescending(item => ... )
    .Select(item => new UserDTO
    {
        UserID = item.UserID,
        UserFullname = $"{item.UserFirstname} {item.UserLastname}",
        UserEmail = item.UserEmail
    }).ToList();
```

<br>

## Try/Catch Restrictions

`try`/`catch` blocks must not be used unless there is no feasible way to guarantee exception-free execution through conditional checks (e.g., `if` statements, `TryParse`, `TryGetValue`, boundary checks, etc.).

Exception handling should be reserved exclusively for scenarios where the application cannot reliably prevent an exception using standard validation or control logic.

<br>

### Rationale

Exceptions are intended for exceptional circumstances — conditions that are outside the control of the developer and cannot be validated in advance. Overuse of `try`/`catch` blocks:

- Masks logic errors and leads to poor code quality.
- Makes debugging significantly more difficult.
- Encourages bypassing proper validation.
- Degrades performance, as exception handling is more expensive than conditional checks.

By mandating proper validation logic, we ensure cleaner, more predictable, and more maintainable code.

<br>

### Appropriate Scenarios for try/catch

`try`/`catch` blocks are allowed only when dealing with operations outside of the application's direct control, including but not limited to:

- File system access (read/write/delete)
- Network operations (HTTP requests, socket communication)
- Database operations (queries, transactions)
- External system integrations (APIs, messaging, third-party services)
- OS-level operations or unmanaged/interop calls

These operations inherently involve unpredictable external factors (permissions, availability, connectivity, corruption, timeouts, etc.) and therefore cannot be validated solely through conditional checks.

<br>

### Example

```csharp
// Wrong, inappropriate use
try
{
    var userID = int.Parse(Request.Query["UserID"]);
}
catch
{
}

// Correct, proper implementation
var userIDQuery = Request.Query["UserID"];
var isUserIDCaptured = int.TryParse(userIDQuery, out int userID);
if (isUserIDCaptured)
{
    ...
}
```

<br>

### Approval Requirement

If you believe that a `try`/`catch` block is inevitable:

- Document the reason.
- Show that the exception condition cannot be handled by validation logic.
- Discuss your arguments with the Team Lead and get approval.
