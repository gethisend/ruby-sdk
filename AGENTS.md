# Ruby SDK guidance

This independent repository packages the `hisend` gem. Minimum Ruby version and
development dependencies live in `hisend.gemspec` (currently Ruby >=2.6 and
Minitest). Maintain that minimum when adding syntax or standard-library calls.
`lib/hisend.rb` contains the client/resources; follow its existing public API.

Use `bundle install` only if dependencies are needed, then run
`bundle exec ruby -Itest test/hisend_test.rb` from this repository.
The Minitest suite stubs `Net::HTTP`; use mocked/local HTTP for regression tests,
not production endpoints. Check authorization, URL/method, JSON parsing and
error behavior for changed resources.

Compare changed request/response contracts with backend and docs when siblings
are available. Preserve backwards compatibility and credential handling. `.gem`
files are release artifacts, not editable source; do not rebuild/publish gems
or change versions unless requested.
