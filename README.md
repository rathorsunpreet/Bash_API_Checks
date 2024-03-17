# Bash API Checks

A shell script which performs API testing of the site [reqres.in](https://reqres.in/).

## Installation

Download the package from [Github](https://github.com/rathorsunpreet/Bash_API_Checks) and unzip it.

## Usage

```console
# Give execute permissions
chmod +x check.sh

# To execute the tests
./check.sh <args>
```
where args can be:

* users
* register
* resources
* login
* all

The arguments are grouped based on the API endpoints being pinged.

## License

[MIT](https://choosealicense.com/licenses/mit/)