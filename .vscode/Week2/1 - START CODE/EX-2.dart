
class BankAccount {
    // TODO
    final String _nameOwner;
    final int _id;
    double _balance = 0.0;

    BankAccount(this._id, this._nameOwner);

    // Returns the current balance
    double get balance => _balance;

    // Deducts the given amount from the account balance.
    // If the balance goes below 0, it should throw an exception.
    double withdraw(double amount) {
      _balance -= amount;

      if (_balance < 0) {
        _balance += amount;
        throw Exception("Insufficient balance for withdrawal!");
      }

      return _balance;
    }

    // Adds the given amount to the account balance.
    double credit(double amount) {
      _balance += amount;
      return _balance;
    }
}

class Bank {
    // TODO
    final String name;
    final List<BankAccount> _accounts = [];

    Bank({required this.name});

    // Create a new bank account.
    // Ensure that the account ID is unique. Otherwise, throw an exception.
    // Add the account to the bank list and return it.
    BankAccount createAccount(int accountId, String accountOwner) {
      for (BankAccount account in _accounts) {
        if (account._id == accountId) {
          throw Exception("Account with ID $accountId already exists!");
        }
      }

      BankAccount newAccount = BankAccount(accountId, accountOwner);
      _accounts.add(newAccount);

      return newAccount;
    }
}

void main() {

  Bank myBank = Bank(name: "CADT Bank");
  BankAccount ronanAccount = myBank.createAccount(100, 'Ronan');

  print(ronanAccount.balance); // Balance: $0
  ronanAccount.credit(100);
  print(ronanAccount.balance); // Balance: $100
  ronanAccount.withdraw(50);
  print(ronanAccount.balance); // Balance: $50

  try {
    ronanAccount.withdraw(75); // This will throw an exception
  } catch (e) {
    print(e); // Output: Insufficient balance for withdrawal!
  }

  try {
    myBank.createAccount(100, 'Hongly'); // This will throw an exception
  } catch (e) {
    print(e); // Output: Account with ID 100 already exists!
  }
}



