<#import "template.ftl" as layout>
  <head>
<title>MatchGuru</title>
  <link rel="icon" type="image/x-icon" href="${url.resourcesPath}/img/favicon.ico" />
  </head>
<@layout.registrationLayout displayMessage=!messagesPerField.existsError('username','password') displayInfo=realm.password && realm.registrationAllowed && !registrationDisabled??; section>
    <#if section = "header">
      <img src="${url.resourcesPath}/img/logo.svg" alt="matchguru"></img>
    <#elseif section = "form">
      <div id="kc-form">
        <div id="kc-form-wrapper">
            <#if realm.password>
              <form id="kc-form-login" onsubmit="login.disabled = true; return true;" action="${url.loginAction}" method="post">
                  <h1 class="login-title">Accedi a MatchGuru</h1>
                  <p class="login-desc">Inserisci le credenziali per accedere</p>
                  <#if !usernameHidden??>
                    <div class="${properties.kcFormGroupClass!}">

                      <input tabindex="2" id="username" class="${properties.kcInputClass!}" name="username" value="${(login.username!'')}"  type="text" autofocus autocomplete="username"
                             aria-invalid="<#if messagesPerField.existsError('username','password')>true</#if>"
                             dir="ltr"
                      />

                        <#if messagesPerField.existsError('username','password')>
                          <span id="input-error" class="${properties.kcInputErrorMessageClass!}" aria-live="polite">
                                        ${kcSanitize(messagesPerField.getFirstError('username','password'))?no_esc}
                                </span>
                        </#if>

                    </div>
                  </#if>

                <div class="${properties.kcFormGroupClass!}">

                  <div class="${properties.kcInputGroup!}" dir="ltr">
                    <input tabindex="3" id="password" class="${properties.kcInputClass!}" name="password" type="password" autocomplete="current-password"
                           aria-invalid="<#if messagesPerField.existsError('username','password')>true</#if>"
                    />
                  </div>

                    <#if usernameHidden?? && messagesPerField.existsError('username','password')>
                      <span id="input-error" class="${properties.kcInputErrorMessageClass!}" aria-live="polite">
                                    ${kcSanitize(messagesPerField.getFirstError('username','password'))?no_esc}
                            </span>
                    </#if>

                </div>

                <div class="${properties.kcFormGroupClass!} ${properties.kcFormSettingClass!}">
                  <div id="kc-form-options">
                      <#if realm.rememberMe && !usernameHidden??>
                        <div class="checkbox">
                          <label>
                              <#if login.rememberMe??>
                                <input tabindex="5" id="rememberMe" name="rememberMe" type="checkbox" checked> ${msg("rememberMe")}
                              <#else>
                                <input tabindex="5" id="rememberMe" name="rememberMe" type="checkbox"> ${msg("rememberMe")}
                              </#if>
                          </label>
                        </div>
                      </#if>
                  </div>
                  <div class="${properties.kcFormOptionsWrapperClass!}">
                      <#if realm.resetPasswordAllowed>
                        <span><a tabindex="6" href="${url.loginResetCredentialsUrl}">${msg("doForgotPassword")}</a></span>
                      </#if>
                  </div>

                </div>

                <div id="kc-form-buttons" class="${properties.kcFormGroupClass!}">
                  <input type="hidden" id="id-hidden-input" name="credentialId" <#if auth.selectedCredential?has_content>value="${auth.selectedCredential}"</#if>/>
                  <input tabindex="7" class="${properties.kcButtonClass!} ${properties.kcButtonPrimaryClass!} ${properties.kcButtonBlockClass!} ${properties.kcButtonLargeClass!}" name="login" id="kc-login" type="submit" value="Accedi"/>
                </div>
              </form>
            </#if>
        </div>
      </div>
      <script type="module" src="${url.resourcesPath}/js/passwordVisibility.js"></script>
    <#elseif section = "info" >
        <#if realm.password && realm.registrationAllowed && !registrationDisabled??>
          <div id="kc-registration-container">
            <div id="kc-registration">
                    <span>${msg("noAccount")} <a tabindex="8"
                                                 href="${url.registrationUrl}">${msg("doRegister")}</a></span>
            </div>
          </div>
        </#if>
    <#elseif section = "socialProviders" >
        <#if realm.password && social?? && social.providers?has_content>
          <div id="kc-social-providers" class="${properties.kcFormSocialAccountSectionClass!}">
            <hr/>
            <h2>${msg("identity-provider-login-label")}</h2>

            <ul class="${properties.kcFormSocialAccountListClass!} <#if social.providers?size gt 3>${properties.kcFormSocialAccountListGridClass!}</#if>">
                <#list social.providers as p>
                  <li>
                    <a id="social-${p.alias}" class="${properties.kcFormSocialAccountListButtonClass!} <#if social.providers?size gt 3>${properties.kcFormSocialAccountGridItem!}</#if>"
                       type="button" href="${p.loginUrl}">
                        <#if p.iconClasses?has_content>
                          <i class="${properties.kcCommonLogoIdP!} ${p.iconClasses!}" aria-hidden="true"></i>
                          <span class="${properties.kcFormSocialAccountNameClass!} kc-social-icon-text">${p.displayName!}</span>
                        <#else>
                          <span class="${properties.kcFormSocialAccountNameClass!}">${p.displayName!}</span>
                        </#if>
                    </a>
                  </li>
                </#list>
            </ul>
          </div>
        </#if>
    </#if>

</@layout.registrationLayout>