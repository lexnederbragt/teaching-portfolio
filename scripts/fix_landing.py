"""
Fixes the 01_main.md so that its title becomes "Introduksjon"
Made to be used in a unix pipe

Usage:

cat book/01_main.md | python scripts/fix_landing.py > book/01_main.md

"""

def fix_landing(md_text):
    """
    Replaces the first two lines.
    """
    result = "# Introduksjon\n\n"
    for line_number, line in enumerate(md_text):
        #print(line_number, line)
        if line_number > 1:
            result += line
    return result

import sys

if __name__ == "__main__":
    md_out = fix_landing(sys.stdin)
    sys.stdout.write(md_out)
