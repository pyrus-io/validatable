# Validatable


1. Create a form structure you want to validate, 
    - Conform to ValidatableStructure and indicate the properties you want evaluated
```
/// RegisterForm.Swift
struct RegisterForm: Equatable, ValidatableStructure {
    
    var validatableProperties: [AnyValidatable] {
        [.init($username), .init( $email), .init($password), .init($confirmPassword)]
    }
    
    @Validatable(rules: [
        .length(min: 3, max: 20),
        .usernameCharacters
    ])
    var username: String = ""
    
    @Validatable(rules: [.email()])
    var email: String = ""

    @Validatable(rules: [
        .length(min: 10, max: 20),
        .passwordCharacters
    ])
    var password: String = ""
    
    @Validatable
    var confirmPassword: String = ""
}
```

2. Implement it in UI
```
struct RegisterForm: View {

    struct RegisterFormState {
        @Validatable(
            rules: [
                .pathsMatch(a: \.password, b: \.confirmPassword)
            ])
        var form = RegisterForm()
    }

    @State var viewState = RegisterFormState()

    var body: some View {
        List {
            TextField("Username", text: $viewState.form.username)
            if viewState.form.$username.validationState.isError {
                Text(viewState.form.$username.validationState.errorMessage)
                    .foregroundColor(.red)
            }
            
            TextField("Email", text: $viewState.form.email)
            if viewState.form.$email.validationState.isError {
                Text(viewState.form.$email.validationState.errorMessage)
                    .foregroundColor(.red)
            }
            
            TextField("Password", text: $viewState.form.password)
            if viewState.form.$password.validationState.isError {
                Text(viewState.form.$password.validationState.errorMessage)
                    .foregroundColor(.red)
            }
            
            TextField("Confirm Password", text: $viewState.form.confirmPassword)
            if viewState.form.$confirmPassword.validationState.isError {
                Text(viewState.form.$confirmPassword.validationState.errorMessage)
                    .foregroundColor(.red)
            }
        }
        .navigationBarTitle(Text("Register"))
    }
}

```
3. Profit 💰💰💰
