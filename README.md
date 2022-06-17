<!-- PROJECT LOGO -->
<br />
<div align="center">
   <h2>
     <a href="https://badddit.herokuapp.com">
       Baddit
     </a>
   </h2>

  <p align="center">
    <a href="https://www.twitter.com/saullbrandao/">
      <img alt="Saull Brandão" src="https://img.shields.io/badge/-saullbrandao-1DA1F2?style=flat&logo=Twitter&logoColor=white" />
    </a>
    <a href="https://www.linkedin.com/in/saullbrandao/">
      <img alt="Saull Brandão" src="https://img.shields.io/badge/-saullbrandao-0A66C2?style=flat&logo=Linkedin&logoColor=white" />
    </a>
    <a href="./LICENSE">
      <img alt="License MIT" src="https://img.shields.io/github/license/saullbrandao/baddit" />
    </a>
    <a href="https://github.com/saullbrandao/baddit/issues">
    <img alt="Issues" src="https://img.shields.io/github/issues/saullbrandao/baddit" />
    </a>
  </p>
  <h2 align="center">
    App inspired on Reddit.
    <br />
    <br />
  </h2>
</div>

# :bookmark_tabs: Table of Contents

- [About the project](#about-the-project)
- [Technologies](#technologies)
- [Getting started](#getting-started)
  - [Prerequisites](#prerequisites)
  - [Installation](#installation)
- [Issues](#issues)
- [Contributing](#contributing)
- [License](#license)

# :page_with_curl: About the Project

![baddit](https://raw.githubusercontent.com/saullbrandao/baddit/master/demo-light.png)
![baddit](https://raw.githubusercontent.com/saullbrandao/baddit/master/demo-dark.png)

- Inspired by Reddit
- Can create posts, join communities, vote and comment
- Uses PostgreSQL as database
- Only authenticated users can create, comment and vote on posts
- Light and dark mode

# :computer: Technologies

- [Ruby on Rails](https://github.com/rails/rails)
- [Tailwind CSS](https://github.com/tailwindlabs/tailwindcss)
- [devise](https://github.com/heartcombo/devise)
- [Hotwire](https://hotwired.dev)

# :rocket: Getting Started

## Prerequisites

You will need to install Ruby and Ruby on Rails

- [Ruby 3.1.2](https://www.ruby-lang.org/en/)
- [Ruby on Rails 7](https://guides.rubyonrails.org/getting_started.html#creating-a-new-rails-project-installing-rails)
- [PostgreSQL](https://www.postgresql.org/download/)

## Installation

```sh
# Clone Repository
$ git clone https://github.com/saullbrandao/baddit.git && cd baddit

# Install Gems
$ bundle install

# Run migrations
$ bin/rails db:migrate

# Run Application
$ bin/dev
```

This starts the development server on http://localhost:3000/

# :interrobang: Issues

Create a <a href="https://github.com/saullbrandao/baddit/issues">new issue
report</a>, it will be an honor to be able to help you solve and further improve
our application.

# :mailbox: Contributing

- Fork this repository;
- Create a new branch to develop your feature: `git checkout -b my-feature`;
- Commit your changes: `git commit -m 'feat: my new feature'`;
- Push to your branch: `git push origin my-feature`.
- Open a Pull Request

# :lock: License

Distributed under the MIT License. See [LICENSE](./LICENSE) for more
information. Made by [Saull Brandão](https://www.linkedin.com/in/saullbrandao/).
<br/> <br/>
