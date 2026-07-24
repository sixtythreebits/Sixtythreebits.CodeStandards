# Products Repository Implementation Exercise

This exercise will demonstrate the full implementation of the Products repository class.

<br>

## ProductsRepository Class Implementation

Navigate to **SixtyThreeBits.Core → Infrastructure → Repositories** and create a new **Products** directory. Then create two items within the Products directory:

- A **DTO** subdirectory for data transfer objects
- A **ProductsRepository.cs** file for the repository class

![Solution Explorer showing the new Products directory under Infrastructure/Repositories, containing a DTO subdirectory and ProductsRepository.cs](../images/04_63BITS_Repositories_01_Todo_Repository_Implementation/image1.png)

<br>

Open the **ProductsRepository.cs** file and configure the class according to the screenshot below.

![ProductsRepository.cs configured as a public class named ProductsRepository, with a Constructors region containing the constructor and an empty Methods region](../images/04_63BITS_Repositories_01_Todo_Repository_Implementation/image2.png)

<br>

## ProductsIUD Method Implementation

Navigate to the **DTO** subdirectory and create a new file, **ProductsIudDTO.cs**, and implement it according to the screenshot below.

![ProductIudDTO.cs defining a public record ProductIudDTO with properties ProductName, ProductPrice, ProductCoverImageFilename, CategoryID, and ProductIsPublished](../images/04_63BITS_Repositories_01_Todo_Repository_Implementation/image3.png)

<br>

Below is a demonstration of how the ProductsIUD stored procedure's `@productJson` values match up to the ProductIudDTO properties.

![SQL Server query window and ProductIudDTO.cs side by side, with arrows connecting the ProductsIUD stored procedure's @productJson columns to the matching ProductIudDTO properties](../images/04_63BITS_Repositories_01_Todo_Repository_Implementation/image4.png)

<br>

Go back to the **ProductsRepository.cs** file and implement the ProductsIUD method according to the screenshot below.

![ProductsRepository.cs with the ProductsIUD method implemented, calling TryToReturnAsyncTask and using SqlQueryBuilder to execute the ProductsIUD stored procedure](../images/04_63BITS_Repositories_01_Todo_Repository_Implementation/image5.png)

<br>

## ProductsList Method Implementation

Navigate to the **DTO** subdirectory and create a new file, **ProductsListDTO.cs**, and implement it according to the screenshot below.

![ProductsListDTO.cs defining a public record ProductsListDTO with properties ProductID, ProductName, ProductPrice, ProductCoverImageFilename, CategoryID, ProductIsPublished, and ProductDateCreated](../images/04_63BITS_Repositories_01_Todo_Repository_Implementation/image6.png)

<br>

Below is a demonstration of how the ProductsList SQL function's columns match up with the ProductsListDTO properties.

![SQL Server query window showing the ProductsList function and ProductsListDTO.cs side by side, with arrows connecting each selected column to the matching ProductsListDTO property](../images/04_63BITS_Repositories_01_Todo_Repository_Implementation/image7.png)

<br>

Go back to the **ProductsRepository.cs** file and implement the ProductsList method according to the screenshot below.

![ProductsRepository.cs with the ProductsList method implemented, calling TryToReturnAsyncTask and using SqlQueryBuilder to execute the ProductsList table-valued function](../images/04_63BITS_Repositories_01_Todo_Repository_Implementation/image8.png)

<br>

## ProductsGetSingleByID Method Implementation

Navigate to the **DTO** subdirectory and create a new file, **ProductDTO.cs**, and implement it according to the screenshot below.

![ProductDTO.cs defining a public record ProductDTO with properties including ProductID, ProductName, ProductPrice, CategoryName, and a nested ProductImage record for the ProductImages list](../images/04_63BITS_Repositories_01_Todo_Repository_Implementation/image9.png)

<br>

Go back to the **ProductsRepository.cs** file and implement the ProductsGetSingleByID method according to the screenshot below.

![ProductsRepository.cs with the ProductsGetSingleByID method implemented, calling TryToReturnAsyncTask and using SqlQueryBuilder to execute the ProductsGetSingleByID scalar-valued function](../images/04_63BITS_Repositories_01_Todo_Repository_Implementation/image10.png)

<br>

## Registering the Repository in the Factory

Navigate to **SixtyThreeBits.Core → Factories** and open **RepositoryFactory.cs**. Add a method according to the screenshot below.

![RepositoryFactory.cs with a new CreateProductsRepository method added, returning a new ProductsRepository instance built from _dbContextFactory and _logger](../images/04_63BITS_Repositories_01_Todo_Repository_Implementation/image11.png)
