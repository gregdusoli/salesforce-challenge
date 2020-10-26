@isTest
private class UtilsTest {
  @isTest
  static void validateAccountNumber() {
    Boolean validCpf = Utils.ValidaCPF('92272975020');
    Boolean validCnpj = Utils.ValidaCNPJ('15305913000193');

    Boolean invalidCpf = Utils.ValidaCPF('9227297502');
    Boolean invalidCnpj = Utils.ValidaCNPJ('1530591300019');

    System.assertEquals(validCpf, true);
    System.assert(validCnpj, true);
    System.assertNotEquals(invalidCpf, true, 'Número do cliente é inválido');
    System.assertNotEquals(invalidCnpj, true, 'Número do cliente é inválido');
  }
}
