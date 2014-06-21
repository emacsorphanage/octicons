# octicons

Emacs [octicons](http://octicons.github.com/) utility.

## Requirements

- octicons font

## Function

#### `(octicons font-name)`

Return code point of `font-name`.
This function is interactive function, so you can call it by `M-x octicons`.

```lisp
(octicons "octoface"
```

## Variable

#### `octions-alist`

`alist` whose key is font name and value is codepoint.

## Sample

```lisp
;; Generating following screenshot
(defun insert-octoicons-fonts ()
  (interactive)
  (cl-loop with i = 0
           with colors = '("red" "green" "blue" "yellow" "orange")
           for (name . codepoint) in octicons-alist
           for color = (nth (random (length colors)) colors)
           do
           (let ((beg (point)))
             (insert codepoint)
             (let ((ov (make-overlay beg (point))))
               (overlay-put ov 'face `(:family "github-octicons" :foreground  ,color :height 2.0)))
             (when (= (% i 18) 17)
               (insert "\n"))
             (cl-incf i))))
```

![octicons](image/octicons.png)
