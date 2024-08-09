SwiftTestRepo
Overview
SwiftTestRepo is an iOS application that demonstrates MVVM architecture. It includes features like a custom UITableViewCell, network data fetching, and error handling.
Features
* MVVM Architecture: Organizes the project with Model, ViewModel, and View layers.
* Custom Table View Cells: Uses ContactTableViewCell to display contact details.
* Network Data Fetching: Fetches contact data from a network source.
* Error Handling: Manages network and decoding errors.
* Unit Testing: Tests for view model and network operations.

Key Components
* ContactViewModel: Manages contact data fetching and provides data to the view.
* NetworkHelper: Handles network requests and data decoding.
* MockNetworkHelper: A mock for testing network interactions.
* ContactTableViewCell: Custom cell for displaying contact information.
  
Testing
* ContactViewModelTests: Validates view model functionality.
* NetworkHelperTests: Tests network data fetching and error scenarios.
