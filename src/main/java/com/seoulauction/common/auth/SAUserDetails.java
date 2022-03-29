package com.seoulauction.common.auth;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.security.authentication.AnonymousAuthenticationToken;
import org.springframework.security.authentication.RememberMeAuthenticationToken;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;

import javax.servlet.http.HttpServletRequest;
import java.util.Collection;
import java.util.List;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class SAUserDetails implements UserDetails {

	private String loginId;
    private int userNo;
    private String password;
    private List<GrantedAuthority> authorities;
    private String userKind;

	private String userNm;
	private String agreeYn;
	private String ip;
    
	public SAUserDetails(String loginId, String password, int userNo, List<GrantedAuthority> authorities) {
    	this.loginId = loginId;
		this.password = password;
		this.userNo = userNo;
		this.authorities = authorities;
	}
    
    public SAUserDetails(String loginId, String password, int userNo, List<GrantedAuthority> authorities, String userKind) {
    	this.loginId = loginId;
		this.password = password;
		this.userNo = userNo;
		this.authorities = authorities;
		this.userKind = userKind;
	}
    
    @Override
    public String getUsername() {
    	return this.loginId;
    }
    
	@Override
	public String getPassword() {
		return this.password;
	}


	@Override
	public Collection<? extends GrantedAuthority> getAuthorities() {
        return this.authorities;
	}
	
	
	@Override
	public boolean isAccountNonExpired() {
		return true;
	}

	@Override
	public boolean isAccountNonLocked() {
		return true;
	}

	@Override
	public boolean isCredentialsNonExpired() {
		return true;
	}

	@Override
	public boolean isEnabled() {
		return true;
	}

	public static SAUserDetails getLoginUser(HttpServletRequest request){
		Authentication userToken;

		if ( request.getUserPrincipal() instanceof UsernamePasswordAuthenticationToken){
			userToken = SecurityContextHolder.getContext().getAuthentication();
		} else {
			userToken = SecurityContextHolder.getContext().getAuthentication();
		}

		SAUserDetails user = null;

		if(userToken != null && !(userToken instanceof AnonymousAuthenticationToken)){
			user = (SAUserDetails) (userToken instanceof RememberMeAuthenticationToken ? userToken.getPrincipal() : userToken.getDetails());
		}
		return user;
	}
}
