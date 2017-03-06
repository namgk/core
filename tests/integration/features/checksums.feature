Feature: checksums

  Scenario: Uploading a file with checksum should work
    Given user "user0" exists
    When user "user0" uploads file "data/textfile.txt" to "/myChecksumFile.txt" with checksum "MD5:d70b40f177b14b470d1756a3c12b963a"
    Then The webdav response should have a status code "201"

  Scenario: Uploading a file with checksum should return the checksum in the propfind
    Given user "user0" exists
    And user "user0" uploads file "data/textfile.txt" to "/myChecksumFile.txt" with checksum "MD5:d70b40f177b14b470d1756a3c12b963a"
    When user "user0" request the checksum of "/myChecksumFile.txt" via propfind
    Then The webdav checksum should match "SHA1:3ee962b839762adb0ad8ba6023a4690be478de6f"

  Scenario: Uploading a file with checksum should return the checksum in the download header
    Given user "user0" exists
    And user "user0" uploads file "data/textfile.txt" to "/myChecksumFile.txt" with checksum "MD5:d70b40f177b14b470d1756a3c12b963a"
    When user "user0" downloads the file "/myChecksumFile.txt"
    Then The header checksum should match "SHA1:3ee962b839762adb0ad8ba6023a4690be478de6f"

  Scenario: Moving a file with checksum should return the checksum in the propfind
    Given user "user0" exists
    And user "user0" uploads file "data/textfile.txt" to "/myChecksumFile.txt" with checksum "MD5:d70b40f177b14b470d1756a3c12b963a"
    When User "user0" moved file "/myChecksumFile.txt" to "/myMovedChecksumFile.txt"
    And user "user0" request the checksum of "/myMovedChecksumFile.txt" via propfind
    Then The webdav checksum should match "SHA1:3ee962b839762adb0ad8ba6023a4690be478de6f"

  Scenario: Moving file with checksum should return the checksum in the download header
    Given user "user0" exists
    And user "user0" uploads file "data/textfile.txt" to "/myChecksumFile.txt" with checksum "MD5:d70b40f177b14b470d1756a3c12b963a"
    When User "user0" moved file "/myChecksumFile.txt" to "/myMovedChecksumFile.txt"
    And user "user0" downloads the file "/myMovedChecksumFile.txt"
    Then The header checksum should match "SHA1:3ee962b839762adb0ad8ba6023a4690be478de6f"

  Scenario: Copying a file with checksum should return the checksum in the propfind
    Given user "user0" exists
    And user "user0" uploads file "data/textfile.txt" to "/myChecksumFile.txt" with checksum "MD5:d70b40f177b14b470d1756a3c12b963a"
    When User "user0" copied file "/myChecksumFile.txt" to "/myChecksumFileCopy.txt"
    And user "user0" request the checksum of "/myChecksumFileCopy.txt" via propfind
    Then The webdav checksum should match "SHA1:3ee962b839762adb0ad8ba6023a4690be478de6f"

  Scenario: Copying file with checksum should return the checksum in the download header
    Given user "user0" exists
    And user "user0" uploads file "data/textfile.txt" to "/myChecksumFile.txt" with checksum "MD5:d70b40f177b14b470d1756a3c12b963a"
    When User "user0" copied file "/myChecksumFile.txt" to "/myChecksumFileCopy.txt"
    And user "user0" downloads the file "/myChecksumFileCopy.txt"
    Then The header checksum should match "SHA1:3ee962b839762adb0ad8ba6023a4690be478de6f"

  Scenario: Uploading a chunked file with checksum should return the checksum in the propfind
    Given user "user0" exists
    And user "user0" uploads chunk file "1" of "3" with "AAAAA" to "/myChecksumFile.txt" with checksum "MD5:45a72715acdd5019c5be30bdbb75233e"
    And user "user0" uploads chunk file "2" of "3" with "BBBBB" to "/myChecksumFile.txt" with checksum "MD5:45a72715acdd5019c5be30bdbb75233e"
    And user "user0" uploads chunk file "3" of "3" with "CCCCC" to "/myChecksumFile.txt" with checksum "MD5:45a72715acdd5019c5be30bdbb75233e"
    When user "user0" request the checksum of "/myChecksumFile.txt" via propfind
    Then The webdav checksum should match "SHA1:acfa6b1565f9710d4d497c6035d5c069bd35a8e8"

  Scenario: Uploading a chunked file with checksum should return the checksum in the download header
    Given user "user0" exists
    And user "user0" uploads chunk file "1" of "3" with "AAAAA" to "/myChecksumFile.txt" with checksum "MD5:45a72715acdd5019c5be30bdbb75233e"
    And user "user0" uploads chunk file "2" of "3" with "BBBBB" to "/myChecksumFile.txt" with checksum "MD5:45a72715acdd5019c5be30bdbb75233e"
    And user "user0" uploads chunk file "3" of "3" with "CCCCC" to "/myChecksumFile.txt" with checksum "MD5:45a72715acdd5019c5be30bdbb75233e"
    When user "user0" downloads the file "/myChecksumFile.txt"
    Then The header checksum should match "SHA1:acfa6b1565f9710d4d497c6035d5c069bd35a8e8"

  Scenario: Downloading a file from local storage has correct checksum
    Given user "user0" exists
    And file "prueba_cksum.txt" with text "Test file for checksums" is created in local storage
    When user "user0" downloads the file "/local_storage/prueba_cksum.txt"
    When user "user0" downloads the file "/local_storage/prueba_cksum.txt"
    Then The header checksum should match "SHA1:b14628561796cb8bd049f036bff7948d39a0180a"
