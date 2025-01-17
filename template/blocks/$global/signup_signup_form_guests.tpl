{{if $async_submit_successful=='true'}}
	<div class="modal__window__form  modal__window__form--single cfx">
		<div class="success" {{if $smarty.session.user_id>0}}data-action="refresh"{{/if}}>
			{{if $smarty.session.user_id>0}}
				{{if $smarty.session.status_id==3}}
					{{$lang.signup.success_message_premium_member|replace:"%1%":$lang.project_name}}
				{{else}}
					{{$lang.signup.success_message_active_member|replace:"%1%":$lang.project_name}}
				{{/if}}
			{{else}}
				{{$lang.signup.success_message_not_confirmed_member|replace:"%1%":$lang.project_name}}
			{{/if}}
		</div>
	</div>
{{else}}
	<div id="modal-signup" class="modal popup-holder">
		{{if $smarty.get.error=='only_for_members'}}
			<div class="btn btn--unlock btn--unlock--danger">
				<span class="lock"><i class="icon-lock-shape-20"></i></span>
				<strong class="error-message">
					{{$lang.login.error_message_only_for_members}}
					<span>
							{{$lang.login.error_message_only_for_members_join}}
						</span>
				</strong>
			</div>
		{{/if}}
		<div class="modal__window">
			<h2 class="title title__modal">{{$lang.signup.title|replace:"%1%":$lang.project_name}}</h2>
			<form action="{{$lang.urls.signup}}" data-form="ajax" method="post">
				<div class="generic-error hidden"></div>

				<div class="cols">
					<div class="twocolumn cfx">
						<div class="left">
							{{if $lang.signup.generated_credentials!='true'}}
								<div class="modal__window__form cfx">
									<div class="modal__window__row">
										<label for="signup_username" class="modal__window__label required">{{$lang.signup.field_username}} (*):</label>
										<div class="relative">
											<input id="signup_username" type="text" class="input" name="username" maxlength="100" placeholder="{{$lang.signup.field_username_hint}}">
											<div class="field-error down"></div>
										</div>
									</div>
									<div class="modal__window__row">
										<label for="signup_pass" class="modal__window__label required">{{$lang.signup.field_password}} (*):</label>
										<div class="relative">
											<input id="signup_pass" type="password" name="pass" class="input" placeholder="{{$lang.signup.field_password_hint}}">
											<div class="field-error down"></div>
										</div>
									</div>
									<div class="modal__window__row">
										<label for="signup_pass2" class="modal__window__label required">{{$lang.signup.field_password2}} (*):</label>
										<div class="relative">
											<input id="signup_pass2" type="password" name="pass2" class="input" placeholder="{{$lang.signup.field_password2_hint}}">
											<div class="field-error down"></div>
										</div>
									</div>
									<div class="modal__window__row">
										<label for="signup_email" class="modal__window__label required">{{$lang.signup.field_email}} (*):</label>
										<div class="relative">
											<input id="signup_email" type="text" name="email" class="input" maxlength="100" placeholder="{{$lang.signup.field_email_hint}}">
											<div class="field-error down"></div>
										</div>
									</div>
								</div>
							{{else}}
								<input type="hidden" name="username" value="{{$generated_username}}"/>
								<input type="hidden" name="pass" value="{{$generated_password}}"/>
								<input type="hidden" name="pass2" value="{{$generated_password}}"/>
								<input type="hidden" name="email" value="{{$generated_email}}"/>
							{{/if}}
							<input type="hidden" name="payment_option" value="2"/>
							<ul class="price-list">
								{{if $disable_free_access!=1}}
									<li class="price-list__item">
										<input type="radio" id="r-free" name="payment_option" value="1" {{if $smarty.post.payment_option==1}}checked{{/if}}/>
										<label for="r-free" class="price-list__item__body cfx">
											<span class="price-list__button"></span>
											<span class="price-list__text">
												<strong>{{$lang.memberzone.access_packages.free}}</strong>
												<span>{{$lang.memberzone.access_packages.free_small}}</span>
											</span>
											<span class="price-list__price">$0.00</span>
										</label>
									</li>
								{{/if}}
								{{foreach item="item" from=$card_packages name='packages'}}
									<li class="price-list__item">
										<input type="radio" id="r-{{$smarty.foreach.packages.index}}" name="card_package_id" value="{{$item.package_id}}" {{if $smarty.post.payment_option!=1 && $item.is_default==1}}checked{{/if}}/>
										<label for="r-{{$smarty.foreach.packages.index}}" class="price-list__item__body cfx">
											<span class="price-list__button"></span>
											{{assign var=labelTitle value=$lang.memberzone.access_packages.title[$item.package_id]|default:$item.title}}
											{{assign var=labelTitle value="|"|explode:$labelTitle}}
											<span class="price-list__text">
												<strong>{{$labelTitle[0]}}</strong>
												<span>{{$labelTitle[1]}}</span>
											</span>
											<span class="price-list__price">{{$labelTitle[2]}}</span>
										</label>
									</li>
								{{/foreach}}
							</ul>
							{{if $disable_free_access==1 || $disable_captcha==1}}
								<input type="hidden" name="action" value="signup"/>
								<input type="hidden" name="email_link" value="{{$lang.urls.email_action}}"/>
								<input type="hidden" name="back_link" value="{{$lang.urls.payment_action}}"/>
							{{else}}
								<div class="modal__window__row captcha-control {{if $smarty.post.payment_option!=1}}hidden{{/if}}">
									<h6 class="title title_tiny">{{$lang.common_forms.field_captcha_hint}}</h6>
									{{if $recaptcha_site_key!=''}}
										<div class="image relative" data-name="code">
											<div data-recaptcha-key="{{$recaptcha_site_key}}" data-recaptcha-theme="{{if $lang.theme.style=='dark'}}dark{{else}}light{{/if}}"></div>
											<div class="field-error up"></div>
										</div>
									{{else}}
										<div class="image">
											<img src="{{$lang.urls.captcha|replace:"%ID%":"signup"}}?rand={{$smarty.now}}" alt="{{$lang.common_forms.field_captcha_image}}"/>
											<div class="relative">
												<input type="text" name="code" id="signup_code" class="input" autocomplete="off" placeholder="{{$lang.common_forms.field_captcha}}"/>
												<div class="field-error up"></div>
											</div>
										</div>
									{{/if}}
									<input type="hidden" name="action" value="signup"/>
									<input type="hidden" name="email_link" value="{{$lang.urls.email_action}}"/>
									<input type="hidden" name="back_link" value="{{$lang.urls.payment_action}}"/>
								</div>
							{{/if}}
						</div>
						<div class="right">
							<ul class="profits__list">
								{{foreach from=$lang.memberzone.access_packages.profits_guests item="profit"}}
									<li class="profits__list__item"><i class="ico ico-check"></i><div>{{$profit}}</div></li>
								{{/foreach}}
							</ul>
						</div>
					</div>

					<div class="btn__row">
						<button type="submit" class="btn btn--green btn--bigger">
							{{$lang.signup.btn_continue}} 
							<span class="btn__small-bottom">{{$lang.signup.btn_continue_hint}}</span>
						</button>

						<a href="#" class="link mark-color js-close">Сancel</a>
					</div>
				</div>
			</form>
		</div>
	</div>
{{/if}}