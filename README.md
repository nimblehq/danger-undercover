# danger-undercover

A [Danger](https://github.com/danger/danger) plugin to show [Undercover](https://github.com/grodowski/undercover) report.

## Installation

    $ gem install danger-undercover

## Usage

To use this gem all the instruction provided in [Undercover](https://github.com/grodowski/undercover) must be followed.

To know more about running undercover [visit here](https://github.com/grodowski/undercover#usage)

> Use the `-c --compare ref` flag to specify a git ref (commit hash, branch name, tag) to compare against. 
**This is a recommended usage for CI/CD build environments**, as `undercover` will `exit 1` if there are any warnings.

This plugin provides a command `undercover-report` that uses `undercover` command from 
[Undercover](https://github.com/grodowski/undercover) gem. It takes all the options that `undercover` command takes.

They both works in the same way but what `undercover-report` extra does is it prints `undercover` report to a default
 file in `coverage/undercover.txt`. This makes using `undercover` in CI server much easier.

To use it on a CI server, run the below command before running `Danger` so that the report file is created beforehand
 which `Danger` will use..

    $ undercover-report -c $compare_git_ref

>Here $compare_git_ref as per undercover documentation, can be a commit hash, branch name, or tag. i.e. origin/master
, origin/development


Then in your `Dangerfile` add the following line with the output file 

```ruby
undercover.report
```

## Development

1. Clone this repo
2. Run `bundle install` to setup dependencies.
3. Run `bundle exec rake spec` to run the tests.
4. Use `bundle exec guard` to automatically have tests run as you make changes.
5. Make your changes.

## License

It is free software, and may be redistributed under the terms specified in the [LICENSE] file.

[LICENSE]: /LICENSE

## About

![Nimble](https://assets.nimblehq.co/logo/dark/logo-dark-text-160.png)

This project is maintained and funded by Nimble.

We love open source and do our part in sharing our work with the community!
See [our other projects][community] or [hire our team][hire] to help build your product.

[community]: https://github.com/nimblehq
[hire]: https://nimblehq.co/
