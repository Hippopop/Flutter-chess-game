enum Identity {
  black,
  white,
}

extension Rotate on Identity {
  Identity rotate() {
    return this == Identity.black ? Identity.white : Identity.black;
  }
}
