
Anthropic launched Claude Code for web this morning. It’s an asynchronous coding agent - their answer to OpenAI’s Codex Cloud and Google’s Jules, and has a very similar shape. I had preview access over the weekend and I’ve already seen some very promising results from it.

It’s available online at claude.ai/code and shows up as a tab in the Claude iPhone app as well:


As far as I can tell it’s their latest Claude Code CLI app wrapped in a container (Anthropic are getting really good at containers these days) and configured to --dangerously-skip-permissions. It appears to behave exactly the same as the CLI tool, and includes a neat “teleport” feature which can copy both the chat transcript and the edited files down to your local Claude Code CLI tool if you want to take over locally.

It’s very straight-forward to use. You point Claude Code for web at a GitHub repository, select an environment (fully locked down, restricted to an allow-list of domains or configured to access domains of your choosing, including “*” for everything) and kick it off with a prompt.

While it’s running you can send it additional prompts which are queued up and executed after it completes its current step.

Once it’s done it opens a branch on your repo with its work and can optionally open a pull request.


Claude Code for web’s PRs are indistinguishable from Claude Code CLI’s, so Anthropic told me it was OK to submit those against public repos even during the private preview. Here are some examples from this weekend:

Add query-string-stripper.html tool against my simonw/tools repo - a very simple task that creates (and deployed via GitHub Pages) this query-string-stripper tool.

minijinja vs jinja2 Performance Benchmark - I ran this against a private repo and then copied the results here, so no PR. Here’s the prompt I used.

Update deepseek-ocr README to reflect successful project completion - I noticed that the README produced by Claude Code CLI for this project was misleadingly out of date, so I had Claude Code for web fix the problem.

That second example is the most interesting. I saw a tweet from Armin about his MiniJinja Rust template language adding support for Python 3.14 free threading. I hadn’t realized that project had Python bindings, so I decided it would be interesting to see a quick performance comparison between MiniJinja and Jinja2.

I ran Claude Code for web against a private repository with a completely open environment (* in the allow-list) and prompted:

I’m interested in benchmarking the Python bindings for https://github.com/mitsuhiko/minijinja against the equivalente template using Python jinja2

Design and implement a benchmark for this. It should use the latest main checkout of minijinja and the latest stable release of jinja2. The benchmark should use the uv version of Python 3.14 and should test both the regular 3.14 and the 3.14t free threaded version - so four scenarios total

The benchmark should run against a reasonably complicated example of a template, using template inheritance and loops and such like In the PR include a shell script to run the entire benchmark, plus benchmark implantation, plus markdown file describing the benchmark and the results in detail, plus some illustrative charts created using matplotlib

Note that I would likely have got the exact same result running this prompt against Claude CLI on my laptop. The benefit of Claude Code for web is entirely in its convenience as a way of running these tasks in a hosted container managed by Anthropic, with a pleasant web and mobile UI layered over the top.

Anthropic are framing this as part of their sandboxing strategy
It’s interesting how Anthropic chose to announce this new feature: the product launch is buried half way down their new engineering blog post Beyond permission prompts: making Claude Code more secure and autonomous, which starts like this:

Claude Code’s new sandboxing features, a bash tool and Claude Code on the web, reduce permission prompts and increase user safety by enabling two boundaries: filesystem and network isolation.

I’m very excited to hear that Claude Code CLI is taking sandboxing more seriously. I’ve not yet dug into the details of that - it looks like it’s using seatbelt on macOS and Bubblewrap on Linux.

Anthropic released a new open source (Apache 2) library, anthropic-experimental/sandbox-runtime, with their implementation of this so far.

Filesystem sandboxing is relatively easy. The harder problem is network isolation, which they describe like this:

Network isolation, by only allowing internet access through a unix domain socket connected to a proxy server running outside the sandbox. This proxy server enforces restrictions on the domains that a process can connect to, and handles user confirmation for newly requested domains. And if you’d like further-increased security, we also support customizing this proxy to enforce arbitrary rules on outgoing traffic.

This is crucial to protecting against both prompt injection and lethal trifecta attacks. The best way to prevent lethal trifecta attacks is to cut off one of the three legs, and network isolation is how you remove the data exfiltration leg that allows successful attackers to steal your data.

If you run Claude Code for web in “No network access” mode you have nothing to worry about.

I’m a little bit nervous about their “Trusted network access” environment. It’s intended to only allow access to domains relating to dependency installation, but the default domain list has dozens of entries which makes me nervous about unintended exfiltration vectors sneaking through.

You can also configure a custom environment with your own allow-list. I have one called “Everything” which allow-lists “*”, because for projects like my MiniJinja/Jinja2 comparison above there are no secrets or source code involved that need protecting.

I see Anthropic’s focus on sandboxes as an acknowledgment that coding agents run in YOLO mode (--dangerously-skip-permissions and the like) are enormously more valuable and productive than agents where you have to approve their every step.

The challenge is making it convenient and easy to run them safely. This kind of sandboxing kind is the only approach to safety that feels credible to me.

Update: A note on cost: I’m currently using a Claude “Max” plan that Anthropic gave me in order to test some of their features, so I don’t have a good feeling for how Claude Code would cost for these kinds of projects.

