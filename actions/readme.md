# Before every lab

Generating a GitHub personal access token (PAT) is a straightforward process. Personal access tokens are used as an alternative to using your password for authentication to GitHub, especially when using the GitHub API or other development tools. Here's how you can generate one:

1) Log In to GitHub:

- Go to GitHub and sign in with your account.

2) Access Settings:

- Click on your profile photo in the upper-right corner of any page.
- Click on "Settings" from the dropdown menu.

3) Developer Settings:

- Scroll down to the bottom of the sidebar and click on "Developer settings".

4) Personal Access Tokens:

- In the left sidebar, click on "Personal access tokens".
- Then, click on the “Generate new token” button.

5) Set Token Description:

- Give your token a descriptive name in the "Note" field. This helps you remember the purpose of the token later.

6) Select Scopes:

- Choose the scopes or permissions you want to grant this token. Scopes determine what access the token has. Be cautious with selecting scopes; only choose what's necessary for your use case to enhance security.

- For example, if you need the token for accessing repositories, select the appropriate scopes under the "repo" category.

7) Generate the Token:

- After selecting the scopes, scroll down and click the “Generate token” button.
- GitHub will then generate a new personal access token.

8) Copy the Personal Access Token:

- Important: Make sure to copy your new personal access token now. You won’t be able to see it again!

- Store it somewhere secure. Treat your tokens like passwords and keep them secret.

Note:
- Use tokens carefully: If a token is leaked, it could allow unauthorized access to your repositories or other areas depending on the scopes assigned.

- Regularly review your tokens: Revoke tokens that are no longer in use for security purposes.

- If you suspect a token has been compromised, revoke it immediately and generate a new one.

Personal access tokens are essential for interacting with GitHub programmatically and are a secure way to authenticate for GitHub automation and development workflows.