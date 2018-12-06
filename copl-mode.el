;;; copl-mode.el --- Major mode for CoPL

;; Copyright (C) 2018 igjit

;; Author: igjit <igjit1@gmail.com>
;; URL: https://github.com/igjit/copl-mode
;; Version: 0.0.1
;; Package-Requires: ((emacs "24.3"))

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program. If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;;; Code:

(require 'tex-mode)

(defconst copl--keyword-list
  '("and"
    "by"
    "changes"
    "def"
    "do"
    "doesn't"
    "else"
    "error"
    "evalto"
    "fun"
    "if"
    "in"
    "is"
    "less"
    "let"
    "letcc"
    "match"
    "matches"
    "minus"
    "not"
    "of"
    "plus"
    "rec"
    "ref"
    "shift"
    "skip"
    "than"
    "then"
    "times"
    "to"
    "type"
    "when"
    "while"
    "with"))

(defconst copl--constant-list
  '("S"
    "Z"
    "false"
    "true"))

(defconst copl--rule-name-list
  '("A-Const"
    "A-Minus"
    "A-Plus"
    "A-Times"
    "A-Var"
    "B-And"
    "B-Const"
    "B-Eq"
    "B-Le"
    "B-Lt"
    "B-Minus"
    "B-Not"
    "B-Or"
    "B-Plus"
    "B-Times"
    "C-Assign"
    "C-Cons"
    "C-EvalArg"
    "C-EvalConsR"
    "C-EvalFun"
    "C-EvalFunC"
    "C-EvalFunR"
    "C-EvalR"
    "C-IfF"
    "C-IfT"
    "C-LetBody"
    "C-Lt"
    "C-MatchCons"
    "C-MatchNil"
    "C-Minus"
    "C-Plus"
    "C-Ret"
    "C-RetCont"
    "C-RetRet"
    "C-Seq"
    "C-Skip"
    "C-Times"
    "C-WhileF"
    "C-WhileT"
    "DR-Plus"
    "DR-PlusL"
    "DR-PlusR"
    "DR-Times"
    "DR-TimesL"
    "DR-TimesR"
    "E-App"
    "E-AppErr1"
    "E-AppErr2"
    "E-AppErr3"
    "E-AppErr4"
    "E-AppErr5"
    "E-AppRec"
    "E-Assign"
    "E-BinOp"
    "E-Bool"
    "E-Cnstr0"
    "E-Cnstr1"
    "E-Cnstr2"
    "E-Cnstr3"
    "E-Cons"
    "E-ConsErr1"
    "E-ConsErr2"
    "E-Const"
    "E-Deref"
    "E-Fun"
    "E-If"
    "E-IfErr2"
    "E-IfErr3"
    "E-IfError"
    "E-IfF"
    "E-IfFError"
    "E-IfInt"
    "E-IfT"
    "E-IfTError"
    "E-Int"
    "E-Let"
    "E-LetCc"
    "E-LetErr1"
    "E-LetErr2"
    "E-LetRec"
    "E-LetRecErr"
    "E-Lt"
    "E-Match"
    "E-MatchCons"
    "E-MatchErr1"
    "E-MatchErr2"
    "E-MatchErr3"
    "E-MatchM1"
    "E-MatchM2"
    "E-MatchN"
    "E-MatchNil"
    "E-Minus"
    "E-Nil"
    "E-Plus"
    "E-Ref"
    "E-Reset"
    "E-Shift"
    "E-Times"
    "E-Var"
    "E-Var1"
    "E-Var2"
    "E-VarErr"
    "L-Succ"
    "L-SuccR"
    "L-SuccSucc"
    "L-Trans"
    "L-Zero"
    "M-Cnstr0"
    "M-Cnstr1"
    "M-Cnstr2"
    "M-Cnstr3"
    "M-Cons"
    "M-Nil"
    "M-Var"
    "M-Wild"
    "MR-Multi"
    "MR-One"
    "MR-Zero"
    "NM-BoolCons"
    "NM-BoolNil"
    "NM-Cnstr00H"
    "NM-Cnstr01"
    "NM-Cnstr02"
    "NM-Cnstr03"
    "NM-Cnstr10"
    "NM-Cnstr11A"
    "NM-Cnstr11H"
    "NM-Cnstr12"
    "NM-Cnstr13"
    "NM-Cnstr20"
    "NM-Cnstr21"
    "NM-Cnstr22H"
    "NM-Cnstr22L"
    "NM-Cnstr22R"
    "NM-Cnstr23"
    "NM-Cnstr30"
    "NM-Cnstr31"
    "NM-Cnstr32"
    "NM-Cnstr33H"
    "NM-Cnstr33L"
    "NM-Cnstr33M"
    "NM-Cnstr33R"
    "NM-ConsConsL"
    "NM-ConsConsR"
    "NM-ConsNil"
    "NM-FunCons"
    "NM-FunNil"
    "NM-IntCons"
    "NM-IntNil"
    "NM-NilCons"
    "NM-RecCons"
    "NM-RecNil"
    "P-Succ"
    "P-Zero"
    "R-Plus"
    "R-PlusL"
    "R-PlusR"
    "R-Times"
    "R-TimesL"
    "R-TimesR"
    "T-Abs"
    "T-App"
    "T-Bool"
    "T-Cnstr0"
    "T-Cnstr1"
    "T-Cnstr2"
    "T-Cnstr3"
    "T-Cons"
    "T-Fun"
    "T-If"
    "T-Int"
    "T-Let"
    "T-LetRec"
    "T-Lt"
    "T-Match"
    "T-MatchLast"
    "T-MatchMore"
    "T-Minus"
    "T-Nil"
    "T-Plus"
    "T-Succ"
    "T-Times"
    "T-Var"
    "T-Var1"
    "T-Var2"
    "T-Zero"
    "TP-Cnstr0"
    "TP-Cnstr1"
    "TP-Cnstr2"
    "TP-Cnstr3"
    "TP-Var"
    "TP-Wild"
    "Tr-App"
    "Tr-Bool"
    "Tr-Fun"
    "Tr-If"
    "Tr-Int"
    "Tr-Let"
    "Tr-LetRec"
    "Tr-Lt"
    "Tr-Minus"
    "Tr-Plus"
    "Tr-Times"
    "Tr-Var1"
    "Tr-Var2"))

(defconst copl--type-name-list
  '("bool"
    "int"
    "list"))

(defvar copl-font-lock-keywords
  `((,(regexp-opt copl--keyword-list 'symbols) 1 font-lock-keyword-face)
    (,(regexp-opt copl--constant-list 'symbols) 1 font-lock-constant-face)
    (,(regexp-opt copl--rule-name-list 'symbols) 1 font-lock-builtin-face)
    (,(regexp-opt copl--type-name-list 'symbols) 1 font-lock-type-face)
    ("\\_<\\(\\$[[:alpha:]]+[[:digit:]]*\\)\\_>" 1 font-lock-variable-name-face)))

(define-derived-mode copl-mode prog-mode "CoPL"
  "Major mode for CoPL."

  (setq font-lock-defaults '((copl-font-lock-keywords)))

  ;; comments
  (modify-syntax-entry ?/ ". 12" copl-mode-syntax-table)
  (modify-syntax-entry ?\n ">" copl-mode-syntax-table)
  (modify-syntax-entry ?\( ". 1b" copl-mode-syntax-table)
  (modify-syntax-entry ?* ". 23b" copl-mode-syntax-table)
  (modify-syntax-entry ?\) ". 4b" copl-mode-syntax-table)

  (setq-local comment-start "//")
  (setq-local comment-use-syntax t)

  ;; TODO: implement own indentation
  (setq-local indent-line-function #'latex-indent))

(add-to-list 'auto-mode-alist '("\\.copl$" . copl-mode))

(provide 'copl-mode)

;;; copl-mode.el ends here
