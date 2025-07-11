<#import "template.ftl" as layout>
<#import "components/atoms/button.ftl" as button>
<#import "components/atoms/button-group.ftl" as buttonGroup>
<#import "components/atoms/form.ftl" as form>
<#import "components/atoms/input.ftl" as input>
<#import "components/atoms/link.ftl" as link>

<@layout.registrationLayout
  displayMessage=!messagesPerField.existsError("email", "username", "password", "password-confirm")
  ;
  section
>
  <#if section="header">
    ${msg("registerTitle")}
  <#elseif section="form">
    <@form.kw action=url.registrationAction method="post">
      <#if !realm.registrationEmailAsUsername>
        <@input.kw
          autocomplete="username"
          invalid=messagesPerField.existsError("username")
          label=msg("username")
          message=kcSanitize(messagesPerField.get("username"))
          name="username"
          type="text"
          value=(register.formData.username)!''
        />
      </#if>
      <@input.kw
        autocomplete="email"
        invalid=messagesPerField.existsError("email")
        label=msg("email")
        message=kcSanitize(messagesPerField.get("email"))
        name="email"
        type="email"
        value=(register.formData.email)!''
      />
      <#if passwordRequired??>
        <@input.kw
          autocomplete="new-password"
          invalid=messagesPerField.existsError("password", "password-confirm")
          label=msg("password")
          message=kcSanitize(messagesPerField.getFirstError("password", "password-confirm"))
          name="password"
          type="password"
        />
        <@input.kw
          autocomplete="new-password"
          invalid=messagesPerField.existsError("password-confirm")
          label=msg("passwordConfirm")
          message=kcSanitize(messagesPerField.get("password-confirm"))
          name="password-confirm"
          type="password"
        />
      </#if>
      <#if recaptchaRequired??>
        <div class="g-recaptcha" data-sitekey="${recaptchaSiteKey}" data-size="compact"></div>
      </#if>
      <@buttonGroup.kw>
        <@button.kw color="primary" type="submit">
          ${msg("doRegister")}
        </@button.kw>
      </@buttonGroup.kw>
    </@form.kw>
  <#elseif section="nav">
    <@link.kw color="secondary" href=url.loginUrl size="small">
      ${kcSanitize(msg("backToLogin"))?no_esc}
    </@link.kw>
  </#if>
</@layout.registrationLayout>
