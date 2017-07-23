;;; org-props.el --- Org properties helper

;; Copyright (C) xxxx  -

;; Author: - <xxx@xxx.xxx>
;; Keywords: tools

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;; ---

;;; Code:

;; org-mode properties API

(defun props-entry-properties ()
  (interactive)
  (let ((props-buffer "*Properties*")
        (props (org-entry-properties (point) nil)))
    (with-current-buffer (generate-new-buffer props-buffer)
      (insert (pp-to-string props)))
    (switch-to-buffer-other-window props-buffer)))

(defun props-entry-get (pom property inherit)
  (interactive (list
                (point)
                (read-string "Property key: ")
                (read-string "Check higher levels? (yes or no) ")))
  (message (format "%s" (org-entry-get pom property
                                       (if (equal inherit "no")
                                           inherit
                                           nil)))))

(defun props-entry-put (pom property value)
  (interactive (list
                (point)
                (read-string "Property key: ")
                (read-string "Property value: ")))
  (org-entry-put pom property value))

(defun props-entry-delete (pom property)
  (interactive (list
                (point)
                (read-string "Property key: ")))
  (org-entry-delete pom property))

(defun props-property-keys (include-specials include-defaults
                                             include-columns)
  (interactive (list
                (read-string "Include special properties? (yes or no) ")
                (read-string "Include default properties? (yes or no) ")
                (read-string
                 "Include property namesin COLUMN formats? (yes or no) ")))
  (let ((props-buffer "*Properties*")
        (keys (org-buffer-property-keys
               (or (if (equal include-specials "no")
                       nil
                       include-specials))
               (or (if (equal include-defaults "no")
                       nil
                       include-defaults))
               (or (if (equal include-columns "no")
                       nil
                       include-defaults)))))
    (with-current-buffer (generate-new-buffer "*Properties*")
      (dolist (key keys)
        (insert (format "%s\n" key))))
    (switch-to-buffer props-buffer)))


(provide 'org-props)
;;; org-props.el ends here
