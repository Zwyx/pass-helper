A quick command line tool to retrieve passwords and usernames when using the [`pass`](https://www.passwordstore.org/) password manager.

# Setup

- Download the file `pass-helper.sh`.
- Source it in your `.zshrc` (or the equivalent if you use another shell): `source /path/to/pass-helper.sh`.

# Usage

Instead of retrieving a password with `pass <password>`, use `p <password>`.

This will retrieve the password and put it in the _X selection_ (the « clipboard » accessible with the middle button of the mouse, also called _Primary_).

Additionally, if the second line of the secret starts with `username: `, then the rest of this line will be put in the clipboard.

Then a simple middle click in a field will paste the password, and a `Ctrl+V` in another will paste the username.

An important benefit of putting the password in the X selection, is that clipboard managers will not store it — if configured correctly.

# Notes

`p` has the same autocompletion capabilities than `pass`. So typing `p`, then a space, then hitting the `Tab` key will show the list of passwords.
