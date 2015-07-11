  <div class="wide">
    <h3><a href="#">General Content</a></h3>
    <p>As you can see a mix of html and markdown can be used. Odeke gotta fill this page on what reqs are ideal for contirubting etc.</p>

This is another regular paragraph.

    cached() {
        exists=1
        while read line; do
            linea=(${line// / })
            sha=`sha1sum $1`
            sha=(${sha// / })
            if [ ${linea[1]} == $1 ]
            then
                if [ ${linea[0]} == ${sha[0]} ]; then
                    exists=0
                    break
                else
                    sed -i "\|^$line\$|d" $ABSPATH/.cache
                fi
            fi
        done < $ABSPATH/.cache

        if [ $exists -eq 1 ]; then
            echo `sha1sum $1` >> $ABSPATH/.cache
        return 1
    else
        return 0
    fi
}
</code></pre>

![Alt text](assests/logo9000.png "alt title")

Markdown is a light text markup format and a processor to convert that to HTML.
The originator describes it as follows:

> Markdown is a text-to-HTML conversion tool for web writers.
> Markdown allows you to write using an easy-to-read,
> easy-to-write plain text format, then convert it to
> structurally valid XHTML (or HTML).
>
> -- <http://daringfireball.net/projects/markdown/>

*this is in italic*  and _so is this_

**this is in bold**  and __so is this__

***this is bold and italic***  and ___so is this___



Lists
--------

* an asterisk starts an unordered list
* and this is another item in the list
+ or you can also use the + character
- or the - character

To start an ordered list, write this:

1. this starts a list *with* numbers
+  this will show as number "2"
*  this will show as number "3."
9. any number, +, -, or * will keep the list going.
    * just indent by 4 spaces (or tab) to make a sub-list
        1. keep indenting for more sub lists
    * here i'm back to the second level
        





<img src="http://i.imgur.com/FJecc1V.jpg" alt=""/>

<script src="https://gist.github.com/shaggytwodope/5462663.js"></script>
  </div>

