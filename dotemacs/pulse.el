(require 'pulse)
(pulse-toggle-integration-advice t)
(defadvice back-button-local-forward (after pulse-advice activate)
  "Cause the current line of buffer to pulse when the cursor gets there."
  (when (and pulse-command-advice-flag (interactive-p))
    (pulse-momentary-highlight-one-line (point))))
(defadvice back-button-local-backward (after pulse-advice activate)
  "Cause the current line of buffer to pulse when the cursor gets there."
  (when (and pulse-command-advice-flag (interactive-p))
    (pulse-momentary-highlight-one-line (point))))
(defadvice ido-switch-buffer (after pulse-advice activate)
  "Cause the current line of new buffer to pulse when the cursor gets there."
  (when (and pulse-command-advice-flag (interactive-p))
    (pulse-momentary-highlight-one-line (point))))
(defadvice visit-.emacs (after pulse-advice activate)
  "Cause the current line of .emacs buffer to pulse when the cursor gets there."
  (when (and pulse-command-advice-flag (interactive-p))
    (pulse-momentary-highlight-one-line (point))))
(defadvice beginning-of-buffer (after pulse-advice activate)
  "Cause the current line of buffer to pulse when the cursor gets there."
  (when (and pulse-command-advice-flag (interactive-p))
    (pulse-momentary-highlight-one-line (point))))
(defadvice end-of-buffer (after pulse-advice activate)
  "Cause the current line of buffer to pulse when the cursor gets there."
  (when (and pulse-command-advice-flag (interactive-p))
    (pulse-momentary-highlight-one-line (point))))
(defadvice beginning-of-defun (after pulse-advice activate)
  "Cause the current line of buffer to pulse when the cursor gets there."
  (when (and pulse-command-advice-flag (interactive-p))
    (pulse-momentary-highlight-one-line (point))))
(defadvice end-of-defun (after pulse-advice activate)
  "Cause the current line of buffer to pulse when the cursor gets there."
  (when (and pulse-command-advice-flag (interactive-p))
    (pulse-momentary-highlight-one-line (point))))