public with sharing class Utils {
  @AuraEnabled
  public static Boolean ValidaCPF(String cpf) {
    if (cpf.length() != 11 || cpf.startsWith('-')) {
      return false;
    }
    return true;
  }

  @AuraEnabled
  public static Boolean ValidaCNPJ(String cnpj) {
    if (cnpj.length() != 14 || cnpj.startsWith('-')) {
      return false;
    }
    return true;
  }
}
