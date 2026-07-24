# 63BITS Core Extension Methods

*SixtyThreeBits.Core.Libraries.Extensions — Reference Documentation*

This document describes the mandatory extension methods provided in the SixtyThreeBits.Core.Libraries.Extensions namespace. These helpers exist to eliminate redundant, repeated code and to centralize decisions (such as parsing behavior, encryption keys, and serialization settings) in a single, shared location.

**These extension methods must be used instead of writing equivalent custom code.** Reimplementing this logic locally — for example, wrapping `int.Parse()` in your own try/catch — defeats the purpose of centralization and is not permitted.

The list below covers the most important and most frequently used methods. Additional extension methods exist in SixtyThreeBits.Core → Libraries → Extensions; the ones documented here are the ones every developer should know by heart.

<br>

## General Behavior

A consistent pattern applies across nearly all of these methods: **they never throw exceptions for bad input.** Instead, when a value cannot be parsed, decoded, or decrypted, they return `null` (or `false`, for the rare method that returns a non-nullable boolean). This means you can safely call them on user input or external data without wrapping them in try/catch, and it keeps your code aligned with the Try/Catch Restrictions defined in the C# development rules.

<br>

## Parsing Extensions

These methods convert a string into a strongly typed, nullable value. If the string doesn't represent a valid value of that type, the method returns `null` rather than throwing.

| Method | Returns | Description |
|---|---|---|
| `.ToInt()` | `int?` | Parses a string into an integer. Returns null if the string isn't a valid int. |
| `.ToLong()` | `long?` | Parses a string into a long. Returns null if the string isn't a valid long. |
| `.ToDecimal()` | `decimal?` | Parses a string into a decimal. Returns null if the string isn't a valid decimal. |
| `.ToByte()` | `byte?` | Parses a string into a byte. Returns null if the string isn't a valid byte. |
| `.ToBoolean()` | `bool?` | Parses a string into a boolean. Returns null if the string isn't a valid boolean. |
| `.ToBooleanValue()` | `bool` | Parses a string into a boolean. Returns false (not null) if the string isn't a valid boolean. |
| `.ToDateTime()` | `DateTime?` | Parses a string into a DateTime. Returns null if the string isn't a valid date/time. |

**Example:**

```csharp
var userAgeQuery = Request.Query["UserAge"];

var userAge = userAgeQuery.ToInt();

if (userAge != null)
{
    ...
}
```

<br>

## JSON Extensions

| Method | Returns | Description |
|---|---|---|
| `.ToJson()` | `string` | Serializes an object into a JSON string. |
| `.DeserializeJsonTo<T>()` | `T?` | Deserializes a JSON string into an object of type T. Returns null if deserialization isn't possible. |

**Example:**

```csharp
var userJson = user.ToJson();

var userDeserialized = userJson.DeserializeJsonTo<UserDTO>();
```

<br>

## Encoding Extensions

| Method | Returns | Description |
|---|---|---|
| `.Base64Encode()` | `string` | Encodes a string into Base64 format. |
| `.Base64Decode()` | `string?` | Decodes a Base64-encoded string. Returns null if the input isn't valid Base64. |

<br>

## Encryption Extensions

These methods use AES (with the application's default encryption key) to securely encrypt and decrypt strings, encoding the result as Base64.

| Method | Returns | Description |
|---|---|---|
| `.Encrypt()` | `string` | Encrypts a string using AES with the default key, then encodes the result as Base64. |
| `.Decrypt()` | `string?` | Decrypts a string previously encrypted with `.Encrypt()`. Returns null if decryption isn't possible. |
| `.EncryptID()` | `string` | Encrypts a database ID using `.Encrypt()`. Use this whenever a database table ID needs to appear in a route or query parameter, so raw IDs are never exposed to the client. |
| `.DecryptID()` | `int?` | Decrypts an ID previously encrypted with `.EncryptID()`. Returns null if decryption isn't possible. |

**Rule of thumb:** any database ID that gets exposed in a URL (route or query string) must go through `.EncryptID()` on the way out and `.DecryptID()` on the way back in. Never expose raw database IDs directly.

<br>

### One-Way Hashing

| Method | Returns | Description |
|---|---|---|
| `.MD5Encrypt()` | `string` | Hashes a string using MD5. |
| `.SHA256Encrypt()` | `string` | Hashes a string using SHA256. |

These are one-way hashes (not reversible), unlike `.Encrypt()`/`.Decrypt()`, which are meant to be reversed.

<br>

## Text Utility Extensions

| Method | Returns | Description |
|---|---|---|
| `.ToAZ09Dash()` | `string` | Strips a string down to only a-z, 0-9, and -. Used to generate a safe filename for file uploads while keeping it recognizable from the original name. |
| `.GetInitials()` | `string` | Returns the uppercase first letter of each word, concatenated. Commonly used to show a user's initials from their first and last name (e.g. "Joe Doe" → "JD"). |
| `.StripHtml()` | `string` | Removes all HTML tags from a string, leaving plain text only. |

<br>

## Collection Extensions

| Method | Returns | Description |
|---|---|---|
| `.HasElements()` | `bool` | Checks whether a collection has any elements. Safe to call on a null collection — it simply returns false, so no separate null check is needed beforehand. |
| `.SelectWithNextAndPrevious()` | `IEnumerable<...>` | An enhanced version of LINQ's Select, which exposes the previous and next item alongside the current one during projection. If there is no previous or next element (e.g. at the start or end of the collection), that value is null. |

**Example:**

```csharp
var hasUsers = users.HasElements();

if (hasUsers)
{
    ...
}
```

<br>

## Where to Find More

Additional extension methods beyond this list live in SixtyThreeBits.Core → Libraries → Extensions. The methods documented above are the most commonly needed ones and should be the first place developers look before writing custom conversion, encryption, or collection-handling logic.
