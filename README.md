![Build And Deploy](https://github.com/qualle-admin/qualle-web/workflows/Build%20and%20Deploy/badge.svg)
# GitHub Actions for Zapier

This Action for [zapier-platform-cli](https://platform.zapier.com/) enables arbitrary actions with the `zapier` command-line client.

## Inputs

- `args` - **Required**. This is the arguments you want to use for the `zapier-platform` cli

## Environment variables

- `ZAPIER_DEPLOY_KEY` - **Required if ZAPIER_DEPLOY_KEY is not set**. The token to use for authentication. This token can be aquired through the `zapier login` command.

- `key` - **Optional**. To specify a specific project to use for all commands. Not required if you specify a project in your `.zapierrc` file.

## Example

To authenticate with Zapier, and deploy to Zapier Hosting:

```yaml
name: Build and Deploy
on:
  push:
    branches:
      - master

jobs:
  build:
    name: Build
    runs-on: ubuntu-latest
    steps:
      - name: Checkout Repo
        uses: actions/checkout@master
      - name: Install Dependencies
        run: yarn
      - name: Build
        run: yarn build
      - name: Archive Production Artifact
        uses: actions/upload-artifact@master
        with:
          name: build
          path: build
  deploy:
    name: Deploy
    needs: build
    runs-on: ubuntu-latest
    steps:
      - name: Checkout Repo
        uses: actions/checkout@master
      - name: Download Artifact
        uses: actions/download-artifact@master
        with:
          name: build
          path: build
      - name: Deploy to Zapier
        uses: qualle-admin/zapier-action@master
        with:
          args: zapier push
        env:
          ZAPIER_DEPLOY_KEY: ${{ secrets.ZAPIER_DEPLOY_KEY }}
```

## License

The Dockerfile and associated scripts and documentation in this project are released under the [MIT License](LICENSE).

### Recommendation

If you decide to do seperate jobs for build and deployment (which is probably advisable), then make sure to clone your repo as the zapier-platform-cli requires the zapier repo to deploy
