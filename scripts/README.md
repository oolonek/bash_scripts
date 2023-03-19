# tw2md.sh

`tw2md.sh` is a Bash script that allows you to parse a [Taskwarrior](https://taskwarrior.org/) output and format the output as a Markdown table. 

The script exports all "next" tasks as JSON and stores them in a variable. It then loops through all tasks and prints them in a Markdown table format.

## Usage

By default, the script exports the next three tasks. To specify a different export argument, simply provide it as a command-line argument to the script. For example, to export all tasks due today, you could run:

```bash
./tw2md.sh due:today
```

The script will print a Markdown table of the exported tasks to the terminal.

## Output

The output Markdown table has the following columns:

| Column     | Description                                            |
|------------|--------------------------------------------------------|
| Project    | The project the task belongs to                         |
| Description| The description of the task                             |
| Due Date   | The due date of the task, in `YYYY-MM-DD` format        |
| Tags       | The tags associated with the task, separated by commas |

## Requirements

`tw2md.sh` requires the following tools to be installed on your system:

- [Taskwarrior](https://taskwarrior.org/)
- [jq](https://stedolan.github.io/jq/)

## License

This script is licensed under the [MIT License](https://opensource.org/licenses/MIT). Feel free to use, modify, and distribute the script as you wish.

