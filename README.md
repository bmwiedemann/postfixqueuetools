## Why

Sometimes you need to manipulate files that are already in the postfix mail queue.

This repo provides tools for that task.

## Usage

`rewritepostqueue.sh MAILQUEUEID`

## Example Output

```
# rewritepostqueue.sh D31192C148
receiver: someone@netiq.com -> someone@suse.com
length:              739 -> 738
```

## Notes

The example code in the `rewritepostqueue` perl script replaces the recipient address domain part.
There are a few simplifications and assertions covered by a "die" - if you hit it, code needs to be extended.
