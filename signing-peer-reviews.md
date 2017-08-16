# Signing peer review with PGP signatures

Peer reviews are one of the supporting pillars of academic authority and
credibility. We therefore need to not have to trust the entity facilitating the
review process, but ourselves be able to verify with absolute certainty the
authenticity of a review. We also need to be sure that the review refers to the
document that we think it refers to. Finally, we need to ensure that the author
of the document and the reviewer both can be sure that the document submitted is
identical to the document reviewed.

The problem of verifying the authenticity and origin of digital documents is
old, and the problem to a wide extent solved. So how can we use modern
cryptography to help us ensure the quality and integrity of the peer review
process? This is a first naive note on that.

To get an idea about how GPG signing works, we need a bit of background. Each
user has a private and a public key. Both are just files containing a very long
and very garbled-looking string of characters, the result of a very mathy
cryptographic process.

When I sign a file with my private key, it can be verified that I really signed
it with my public key. The system is contrived in such a way that the
verification of the signature **only** will succeed when it is done with the
public key that corresponds to the private key with which it was signed. This
means that only my public key will be able to verify that the file was signed by
me. If the file is modified in any way compared to how it looked when I signed
it, it will also not be able to verify the signature. This guarantees that (1)
I acknowledge that I have signed the file, and (2) that it has changed in now
way since I signed it.

The elements involved in the peer review process are (1) the author submitting
his material for review, (2) the material submitted, and (3) the reviewer.

Imagine the following review process:

-   I want to submit a file for review, and as I submit it, I also sign it with my
    private key.
-   When the reviewer receives my file, she will verify the signature to make sure
    nothing has changed since I sent it.
-   When she is done with her review, she creates a review statement. She
    finishes the process by signing the review statement with her own private key
    for later verification.

The review statement contains (among other things such as review comments, date
etc.):

-   A unique id (or digest?) of the statement.
-   The sha digest of my original document. This ensures that the document that
    has been reviewed is identical to the one I submitted.
-   Digests of other representations (HTML or PDF) used by the reviewer will also
    be part of the statement.

This review statement can then be verified in the following way:

-   A register contains references to all signatures that have been made with the
    current review statement (by id or digest).
-   For each signature that is registered for this review, verify that the
    signature is correct.
-   and verify that the digest of the original document in the review statement is
    identical to the digest of the original document.

If any of those steps fail, the review is not valid.

A document can have any number of reviews this way. Only disadvantage is that it
requires a register with references to all the signatures that have signed a
statement.

Why not just use sha digests? By having the author sign her submission and the
reviewer verify it during the process, it will be very difficult for the author
to claim that what is reviewed is not identical to what she submits (that would
imply the loss of her private key). By requiring the reviewer to sign the
review, we make it equally difficult for the reviewer to claim that the review
is tampered with or counterfeited.

Questions:
-   How about when we want to submit multiple files?
-   Is there a way to avoid the separation of signature and statement while
    still keeping the statement in a clear text format?

Some background of GPG file signing:
- https://www.gnupg.org/gph/en/manual/x135.html

