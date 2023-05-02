# Purchase App

It is an android application developed using Flutter.

Purchase app is a user-friendly platform that allows users to browse through a variety of products, add them to their favorite list, and purchase items by adding them to their cart.  

This app includes User Authentication, Registering new users, adding their favorite items to the fav list, adding items to the cart and if in case if they want to remove any items from either of these, it can also be done.

This app includes several screens which are
- Launch screen 
- Login Screen
- Register Screen
- UserForm
- Home Screen
- Cart Screen
- Favorite Screen
- User Screen
- Payment Screen
- Payment-success Screen

Login Screen is for the users to login into the app, if the user does not have an account, they can create their own account and continue with using the app. This will then navigate to the userfrom screen where the users will be asked about their details like phone number, age etc..


HomeScreen will have all the items to be purchased, it also cantains a search bar for the users to search for particular item. The users can save the items as favorite and can add them to the cart.


Fovourite Screen will contain all the items that are seleted as favourite by the users, similarly Cart screen will have all the items that are added to the cart and will also display the total cost of all the items that are in the cart. Cart screen will have a button called Checkout which will take the user to the payment page.

Payment page will display the total amount that is to be paid along with all the payment methods. The user now has to choose his method of payment.


Once the payment is done then it will display a screen with a payment success message.


Firebase is used for user authentication, to store the user details, and to store the items added to the cart, added as favourite by the users. This informations is stored for all the users separately, as soon as the user clicks the add-to-cart botton that particular item will be stored in the firebase cloud as a collection called 'Users-Cart-Items', similarly if the user adds a item in the favourite list, that particular item will be stored as a collection called 'Users-favourite-Items'.

