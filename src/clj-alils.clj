#!/usr/bin/env bb

;; list all aliases available from the current context
;; based on :config-files from `clojure -Sdescribe` (really deps.clj instead of clojure)

;;;;;;;;;;;;
;; .bashrc excerpt:
;;_clj_complete () {
;;  if [[$3 == ":"]]; then
;;    COMPREPLY= ($ (compgen -W "$(clj-alils)" -- $ {COMP_WORDS [COMP_CWORD]}))
;;  else
;;    COMPREPLY= ($ (compgen -o default $2))
;;  fi
;;}
;;
;;complete -o filenames -F _clj_complete clojure
;;;;;;;;;;;;;

;; known issues:
;; - if an alias name matches a directory name, a slash will be appended
;;   (because the shell doesn't know the difference)
;; - doesn't currently find tools by file name (e.g. -Ttools)

(defn configs []
  (->> (with-out-str (babashka.tasks/clojure "-Sdescribe"))
       clojure.edn/read-string
       :config-files))

(defn aliases-from-config [path]
  (->> (clojure.edn/read-string (slurp path))
       :aliases
       keys
       (map name)))

(defn main []
  (->> (configs)
       (mapcat aliases-from-config)
       dedupe))

(when (= *file* (System/getProperty "babashka.file"))
  (run! println (main)))
