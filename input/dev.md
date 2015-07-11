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


![Alt text](assests/logo9000.png "alt title")



<script src="https://gist.github.com/shaggytwodope/5462663.js"></script>
  </div>

